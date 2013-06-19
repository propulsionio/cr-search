# -*- coding: utf-8 -*-
require 'sinatra'
require 'newrelic_rpm'
require 'json'
require 'rsolr'
require 'mongo'
require 'haml'
require 'will_paginate'
require 'cgi'
require 'faraday'
require 'faraday_middleware'
require 'haml'
require 'gabba'
require 'rack-session-mongo'
require 'oauth2'
require 'resque'
require 'open-uri'
require 'uri'
require 'csv'

require_relative 'lib/paginate'
require_relative 'lib/result'
require_relative 'lib/bootstrap'
require_relative 'lib/doi'
require_relative 'lib/orcid'
require_relative 'lib/session'
require_relative 'lib/data'
require_relative 'lib/orcid_update'
require_relative 'lib/orcid_claim'
require_relative 'lib/orcid_auth'

MIN_MATCH_SCORE = 2
MIN_MATCH_TERMS = 3
MAX_MATCH_TEXTS = 1000

after do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

configure do
  config = JSON.parse(File.open('conf/app.json').read)
  config.each_pair do |key, value|
    set key.to_sym, value
  end

  # Work around rack protection referrer bug
  set :protection, :except => :json_csrf

  # Configure solr
  set :solr, RSolr.connect(:url => settings.solr_url)

  # Configure mongo
  set :mongo, Mongo::Connection.new(settings.mongo_host)
  set :dois, settings.mongo[settings.mongo_db]['dois']
  set :shorts, settings.mongo[settings.mongo_db]['shorts']
  set :issns, settings.mongo[settings.mongo_db]['issns']
  set :citations, settings.mongo[settings.mongo_db]['citations']
  set :patents, settings.mongo[settings.mongo_db]['patents']
  set :claims, settings.mongo[settings.mongo_db]['claims']
  set :orcids, settings.mongo[settings.mongo_db]['orcids']
  set :links, settings.mongo[settings.mongo_db]['links']
  set :funders, settings.mongo[settings.mongo_db]['funders']

  # Set up for http requests to data.crossref.org and dx.doi.org
  dx_doi_org = Faraday.new(:url => 'http://dx.doi.org') do |c|
    c.use FaradayMiddleware::FollowRedirects, :limit => 5
    c.adapter :net_http
  end

  set :data_service, Faraday.new(:url => 'http://data.crossref.org')
  set :dx_doi_org, dx_doi_org

  # Citation format types
  set :citation_formats, {
    'bibtex' => 'application/x-bibtex',
    'ris' => 'application/x-research-info-systems',
    'apa' => 'text/x-bibliography; style=apa',
    'harvard' => 'text/x-bibliography; style=harvard3',
    'ieee' => 'text/x-bibliography; style=ieee',
    'mla' => 'text/x-bibliography; style=mla',
    'vancouver' => 'text/x-bibliography; style=vancouver',
    'chicago' => 'text/x-bibliography; style=chicago-fullnote-bibliography'
  }

  # Set facet fields
  set :facet_fields, ['type', 'year', 'oa_status', 'publication', 'category', 'funder_name', 'source']
  set :crmds_facet_fields, ['type', 'year', 'oa_status', 'publication', 'category', 'funder_name', 'source']
  set :fundref_facet_fields, ['type', 'year', 'oa_status', 'publication', 'category', 'source']

  # Google analytics event tracking
  set :ga, Gabba::Gabba.new('UA-34536574-2', 'http://search.labs.crossref.org')

  # Orcid endpoint
  set :orcid_service, Faraday.new(:url => settings.orcid_site)

  # Orcid oauth2 object we can use to make API calls
  set :orcid_oauth, OAuth2::Client.new(settings.orcid_client_id,
                                       settings.orcid_client_secret,
                                       {:site => settings.orcid_site})

  # Set up session and auth middlewares for ORCiD sign in
  use Rack::Session::Mongo, settings.mongo[settings.mongo_db]
  use OmniAuth::Builder do
    provider :orcid, settings.orcid_client_id, settings.orcid_client_secret, :client_options => {
      :site => settings.orcid_site,
      :authorize_url => settings.orcid_authorize_url,
      :token_url => settings.orcid_token_url,
      :scope => '/orcid-profile/read-limited /orcid-works/create'
    }
  end

  # Branding options
  set :crmds_branding, {
    :logo_path => '/cms-logo.png',
    :logo_link => '/',
    :search_placeholder => '',
    :search_action => '/',
    :search_typeahead => false,
    :examples_layout => :crmds_help_list,
    :header_links_profile => :crmds,
    :facet_fields => settings.crmds_facet_fields,
    :downloads => []
  }

  set :fundref_branding, {
    :logo_path => '/frs-logo.png',
    :logo_link => '/fundref',
    :search_placeholder => 'Funder name',
    :search_action => '/fundref',
    :search_typeahead => :funder_name,
    :examples_layout => :fundref_help_list,
    :header_links_profile => :fundref,
    :facet_fields => settings.fundref_facet_fields,
    :downloads => [:fundref_csv]
  }

  set :test_prefixes, ["10.5555", "10.55555"]
end

helpers do
  include Doi
  include Orcid
  include Session

  def partial template, locals
    haml template.to_sym, :layout => false, :locals => locals
  end

  def citations doi
    doi = to_doi(doi)
    citations = settings.citations.find({'to.id' => doi})

    citations.map do |citation|
      hsh = {
        :id => citation['from']['id'],
        :authority => citation['from']['authority'],
        :type => citation['from']['type'],
      }

      if citation['from']['authority'] == 'cambia'
        patent = settings.patents.find_one({:patent_key => citation['from']['id']})
        hsh[:url] = "http://lens.org/lens/patent/#{patent['pub_key']}"
        hsh[:title] = patent['title']
      end

      hsh
    end
  end

  def select query_params
    page = query_page
    rows = query_rows
    results = settings.solr.paginate page, rows, settings.solr_select, :params => query_params
  end

  def select_all query_params
    page = 0
    rows = 60000000 # TODO collect pages instead
    results = settings.solr.paginate page, rows, settings.solr_select, :params => query_params
  end

  def response_format
    if params.has_key?('format') && params['format'] == 'json'
      'json'
    else
      'html'
    end
  end

  def query_page
    if params.has_key? 'page'
      params['page'].to_i
    else
      1
    end
  end

  def query_rows
    if params.has_key? 'rows'
      params['rows'].to_i
    else
      settings.default_rows
    end
  end

  def query_columns
    ['*', 'score']
  end

  def query_terms
    query_info = query_type
    case query_info[:type]
    when :doi
      "doi:\"http://dx.doi.org/#{query_info[:value]}\""
    when :short_doi
      "doi:\"http://doi.org/#{query_info[:value]}\""
    when :issn
      "issn:\"http://id.crossref.org/issn/#{query_info[:value]}\""
    when :orcid
      "orcid:\"http://orcid.org/#{query_info[:value]}\""
    else
      scrub_query(params['q'], false)
    end
  end

  def query_type
    if doi? params['q']
      {:type => :doi, :value => to_doi(params['q']).downcase}
    elsif short_doi?(params['q']) || very_short_doi?(params['q'])
      {:type => :short_doi, :value => to_long_doi(params['q'])}
    elsif issn? params['q']
      {:type => :issn, :value => params['q'].strip.upcase}
    elsif orcid? params['q']
      {:type => :orcid, :value => params['q'].strip}
    else
      {:type => :normal}
    end
  end

  def abstract_facet_query
    fq = {}
    settings.facet_fields.each do |field|
      if params.has_key? field
        params[field].split(';').each do |val|
          fq[field] ||= []
          fq[field] << val
        end
      end
    end
    fq
  end

  def facet_query
    fq = []
    abstract_facet_query.each_pair do |name, values|
      values.each do |value|
        fq << "#{name}: \"#{value}\""
      end
    end
    fq
  end

  def sort_term
    if 'year' == params['sort']
      'year desc, score desc'
    else
      'score desc'
    end
  end

  def base_query
    {
      :sort => sort_term,
      :fl => query_columns,
      :rows => query_rows,
      :facet => 'true',
      'facet.field' => settings.facet_fields,
      'facet.mincount' => 1,
      :hl => 'true',
      'hl.preserveMulti' => 'true',
      'hl.fl' => 'hl_*',
      'hl.simple.pre' => '<span class="hl">',
      'hl.simple.post' => '</span>',
      'hl.mergeContinuous' => 'true',
      'hl.snippets' => 10,
      'hl.fragsize' => 0
    }
  end

  def fundref_query
    query = base_query.merge({:q => "funder_doi:\"#{query_terms}\""})
    fq = facet_query
    query['fq'] = fq unless fq.empty?
    query
  end 

  def search_query
    query = base_query.merge({:q => query_terms})
    fq = facet_query
    query['fq'] = fq unless fq.empty?
    query
  end

  def fundref_doi_query funder_dois
    q = funder_dois.map {|doi| "funder_doi:\"#{doi}\""}.join(' OR ')
    query = base_query.merge({:q => q})
    fq = facet_query
    query['fq'] = fq unless fq.empty?
    query
  end

  def result_page solr_result
    {
      :bare_sort => params['sort'],
      :bare_query => params['q'],
      :query_type => query_type,
      :query => query_terms,
      :facet_query => abstract_facet_query,
      :page => query_page,
      :rows => {
        :options => settings.typical_rows,
        :actual => query_rows
      },
      :items => search_results(solr_result),
      :paginate => Paginate.new(query_page, query_rows, solr_result),
      :facets => solr_result['facet_counts']['facet_fields']
    }
  end

  def facet_link_not field_name, field_value
    fq = abstract_facet_query
    fq[field_name].delete field_value
    fq.delete(field_name) if fq[field_name].empty?

    link = "#{request.path_info}?q=#{CGI.escape(params['q'])}"
    fq.each_pair do |field, vals|
      link += "&#{field}=#{CGI.escape(vals.join(';'))}"
    end
    link
  end

  def facet_link field_name, field_value
    fq = abstract_facet_query
    fq[field_name] ||= []
    fq[field_name] << field_value

    link = "#{request.path_info}?q=#{CGI.escape(params['q'])}"
    fq.each_pair do |field, vals|
      link += "&#{field}=#{CGI.escape(vals.join(';'))}"
    end
    link
  end

  def descendants_link id
    "?q=#{id}&descendants=true"
  end

  def no_descendants_link id
    "?q=#{id}"
  end

  def fundref_csv_link id, descendants
    if descendants
      "?q=#{id}&descendants=true&format=csv"
    else
      "?q=#{id}&format=csv"
    end
  end

  def facet? field_name
    abstract_facet_query.has_key? field_name
  end

  def search_link opts
    fields = settings.facet_fields + ['q', 'sort']
    parts = fields.map do |field|
      if opts.has_key? field.to_sym
        "#{field}=#{CGI.escape(opts[field.to_sym])}"
      elsif params.has_key? field
        params[field].split(';').map do |field_value|
          "#{field}=#{CGI.escape(params[field])}"
        end
      end
    end

    "#{request.path_info}?#{parts.compact.flatten.join('&')}"
  end

  def authors_text contributors
    authors = contributors.map do |c|
      "#{c['given_name']} #{c['surname']}"
    end
    authors.join ', '
  end

  def search_results solr_result, oauth = nil
    claimed_dois = []
    profile_dois = []

    if signed_in?
      orcid_record = settings.orcids.find_one({:orcid => sign_in_id})
      unless orcid_record.nil?
        claimed_dois = orcid_record['dois'] + orcid_record['locked_dois'] if orcid_record
        profile_dois = orcid_record['dois']
      end
    end

    solr_result['response']['docs'].map do |solr_doc|
      doi = solr_doc['doi_key']
      plain_doi = to_doi(doi)
      in_profile = profile_dois.include?(plain_doi)
      claimed = claimed_dois.include?(plain_doi)
      user_state = {
        :in_profile => in_profile,
        :claimed => claimed
      }

      SearchResult.new solr_doc, solr_result, citations(solr_doc['doi_key']), user_state
    end
  end

  def scrub_query query_str, remove_short_operators
    query_str = query_str.gsub(/[{}*\"\.\[\]\(\)\-:;\/%]/, ' ')
    query_str = query_str.gsub(/[\+\!\-]/, ' ') if remove_short_operators
    query_str = query_str.gsub(/AND/, ' ')
    query_str = query_str.gsub(/OR/, ' ')
    query_str.gsub(/NOT/, ' ')
  end

  def render_top_funder_name m, names
    top_funder_id = m.keys.first
    names[top_funder_id]
  end

  def render_top_funder_id m
    m.keys.first
  end

  def rest_funder_nesting m
    m[m.keys.first]
  end

  def render_funders m, names, indent, &block
    ks = m.keys
    ks.each do |k|
      if m[k].keys == ['more']
        block.call(indent + 1, k, names[k], true)
      else
        block.call(indent + 1, k, names[k], false)
        render_funders(m[k], names, indent + 1, &block)
      end
    end
  end

  def funder_doi_from_id id, descendants
    dois = ["http://dx.doi.org/10.13039/#{id}"]

    if !descendants
      dois
    else
      dois += settings.funders.find_one({:id => id})['descendants'].map do |id|
        "http://dx.doi.org/10.13039/#{id}"
      end
    end
  end

  def test_doi? doi
    plain_doi = to_doi(doi)
    plain_doi.start_with?('10.5555') || plain_doi.start_with?('10.55555')
  end

  def index_stats
    loc = 'solr-web/crmds1/select'

    count_result = settings.solr.get loc, :params => {
      :q => '*:*',
      :rows => 0
    }
    article_result = settings.solr.get loc, :params => {
      :q => 'type:"Journal Article"',
      :rows => 0
    }
    proc_result = settings.solr.get loc, :params => {
      :q => 'type:"Conference Paper"',
      :rows => 0
    }
    standard_result = settings.solr.get loc, :params => {
      :q => 'type:"Standard"',
      :rows => 0
    }
    report_result = settings.solr.get loc, :params => {
      :q => 'type:"Report"',
      :rows => 0
    }
    fundref_id_result = settings.solr.get loc, :params => {
      :q => 'funder_doi:[* TO *]',
      :rows => 0
    }
    fundref_result = settings.solr.get loc, :params => {
      :q => 'funder_name:[* TO *] OR funder_doi:[* TO *]',
      :rows => 0
    }
    orcid_result = settings.solr.get loc, :params => {
      :q => 'orcid:[* TO *]',
      :rows => 0
    }
    
    book_types = ['Book', 'Book Series', 'Book Set', 'Reference', 
                  'Monograph', 'Chapter', 'Section', 
                  'Part', 'Track', 'Entry']

    book_result = settings.solr.get loc, :params => {
      :q => book_types.map {|t| "type:\"#{t}\""}.join(' OR '),
      :rows => 0
    }

    dataset_result = settings.solr.get loc, :params => {
      :q => 'type:Dataset OR type:Component',
      :rows => 0
    }
    oldest_result = settings.solr.get loc, :params => {
      :q => 'year:[1600 TO *]',
      :rows => 1,
      :sort => 'year asc'
    }

    stats = []

    stats << {
      :value => count_result['response']['numFound'],
      :name => 'Total number of indexed DOIs',
      :number => true
    }

    stats << {
      :value => article_result['response']['numFound'],
      :name => 'Number of indexed journal articles',
      :number => true
    }

    stats << {
      :value => proc_result['response']['numFound'],
      :name => 'Number of indexed conference papers',
      :number => true
    }

    stats << {
      :value => book_result['response']['numFound'],
      :name => 'Number of indexed book-related DOIs',
      :number => true
    }

    stats << {
      :value => dataset_result['response']['numFound'],
      :name => 'Number of indexed figure, component and dataset DOIs',
      :number => true
    }

    stats << {
      :value => standard_result['response']['numFound'],
      :name => 'Number of indexed standards',
      :number => true
    }

    stats << {
      :value => report_result['response']['numFound'],
      :name => 'Number of indexed reports',
      :number => true
    }

    stats << {
      :value => fundref_id_result['response']['numFound'],
      :name => 'Number of FundRef enabled DOIs with funder IDs',
      :number => true
    }

    stats << {
      :value => fundref_result['response']['numFound'],
      :name => 'Total number of FundRef enabled DOIs',
      :number => true
    }

    stats << {
      :value => orcid_result['response']['numFound'],
      :name => 'Number of indexed DOIs with associated ORCIDs',
      :number => true
    }

    stats << {
      :value => oldest_result['response']['docs'].first['year'],
      :name => 'Oldest indexed publication year'
    }

    stats << {
      :value => settings.orcids.count({:query => {:updated => true}}),
      :name => 'Number of ORCID profiles updated',
      :number => true
    }

    stats
  end
end

before do
  set_after_signin_redirect(request.fullpath)
end

get '/fundref' do
  descendants = ['true', 't', '1'].include?(params[:descendants])

  if !params.has_key?('q')
    haml :splash, :locals => {:page => {:branding => settings.fundref_branding}}
  elsif params.has_key?('format') && params['format'] == 'csv'
    funder_dois = funder_doi_from_id(params['q'], descendants)
    solr_result = select_all(fundref_doi_query(funder_dois))
    results = search_results(solr_result)  

    csv_response = CSV.generate do |csv|
      csv << ['DOI', 'Type', 'Year', 'Title', 'Publication', 'Authors', 'Funders']
      results.each do |result|
        csv << [result.doi, 
                result.type, 
                result.coins_year, 
                result.coins_atitle, 
                result.coins_title, 
                result.coins_authors, 
                result.plain_funder_names]
      end
    end

    content_type 'text/csv'
    csv_response
  else
    funder_dois = funder_doi_from_id(params['q'], descendants)
    solr_result = select(fundref_doi_query(funder_dois))
    funder = settings.funders.find_one({:uri => funder_dois.first})
    funder_info = {
      :nesting => funder['nesting'], 
      :nesting_names => funder['nesting_names'],
      :id => funder['id'],
      :descendants => descendants
    }
    page = result_page(solr_result)

    page[:bare_query] = funder['primary_name_display']
    page[:query] = scrub_query(page[:bare_query], false)

    haml :results, :locals => {
      :page => {
        :branding => settings.fundref_branding,
        :funder => funder_info
      }.merge(page)
    }
  end
end

get '/funders/:id/dois' do
  funder_id = params[:id]
  funder_doi = funder_doi_from_id(funder_id, false).first
  
  params = {
    :fl => 'doi',
    :q => "funder_doi:\"#{funder_doi}\"",
    :rows => query_rows
  }
  result = settings.solr.paginate(query_page, query_rows, settings.solr_select, :params => params)

  page = {
    :totalResults => result['response']['numFound'],
    :startIndex => result['response']['start'],
    :itemsPerPage => query_rows,
    :query => {
      :searchTerms => funder_id,
      :startPage => query_page
    },
    :items => result['response']['docs'].map {|r| r['doi']}
  }

  content_type 'application/json'
  JSON.pretty_generate(page)
end

get '/funders/:id/hierarchy' do
  funder = settings.funders.find_one({:id => params[:id]})
  page = {
    :funder => {
      :nesting => funder['nesting'],
      :nesting_names => funder['nesting_names'],
      :id => funder['id'],
      :uri => funder['uri']
    }
  }
  haml :funder, :locals => {:page => page}
end

get '/funders/hierarchy' do
  funder_doi = params['doi']
  funder = settings.funders.find_one({:uri => funder_doi})
  page = {
    :funder => {
      :nesting => funder['nesting'],
      :nesting_names => funder['nesting_names'],
      :id => funder['id'],
      :uri => funder['uri']
    }
  }
  haml :funder, :locals => {:page => page}
end

get '/funders/dois' do
  params = {
    :fl => 'doi',
    :q => 'funder_name:[* TO *]',
    :rows => query_rows,
  }
  result = settings.solr.paginate(query_page, query_rows, settings.solr_select, :params => params)
  
  page = {
    :totalResults => result['response']['numFound'],
    :startIndex => result['response']['start'],
    :itemsPerPage => query_rows,
    :query => {
      :searchTerms => '',
      :startPage => query_page
    },
    :items => result['response']['docs'].map {|r| r['doi']}
  }

  content_type 'application/json'
  JSON.pretty_generate(page)
end

get '/funders' do
  query = {}
  strict = !['0', 'f', 'false'].include?(params['strict'])
  descendants = ['1', 't', 'true'].include?(params['descendants'])

  if params['q']
    query_terms = params['q'].downcase.gsub(/[,\.\-\'\"]/, '').split(/\s+/)
    operator = '$and' if strict
    operator = '$or' unless strict
    query = {operator => []}
    query_terms.each do |t|
      query[operator] << {'name_tokens' => {'$regex' => "^#{t}"}}
    end
  end

  results = settings.funders.find(query, {:sort => [[:level, 1]]})

  if params['format'] == 'csv'
    content_type 'text/csv'
    CSV.generate do |csv|
      results.each do |record|
        csv << [record['uri'], record['primary_name_display']]
      end
    end
  else
    datums = results.map do |result|
      base = {
        :id => result['id'],
        :uri => result['uri'],
        :value => result['primary_name_display'],
        :other_names => result['other_names_display'],
        :tokens => result['name_tokens'],
      }
      if descendants
        base.merge({:descendants => result['descendants'], :descendant_names => result['descendant_names']})
      else
        base
      end
    end

    unless strict
      # Order the results by the number of words they have matched
      datums.each do |datum|
        datum[:count] = (query_terms & datum[:tokens]).count
      end
      
      datums.sort_by! {|datum| datum[:count]}.reverse!
    end
    
    content_type 'application/json'
    JSON.pretty_generate(datums)
  end
end

get '/' do
  if !params.has_key?('q')
    haml :splash, :locals => {
      :page => {
        :query => '', 
        :branding => settings.crmds_branding
      }
    }
  else
    solr_result = select(search_query)
    page = result_page(solr_result)

    haml :results, :locals => {
      :page => page.merge({:branding => settings.crmds_branding})
    }
  end
end

get '/help/api' do
  haml :api_help, :locals => {
    :page => {
      :query => '', 
      :branding => settings.crmds_branding
    }
  }
end

get '/help/search' do
  haml :search_help, :locals => {
    :page => {
      :query => '',
      :branding => settings.crmds_branding
    }
  }
end

get '/help/status' do
  haml :status_help, :locals => {
    :page => {
      :branding => settings.crmds_branding,
      :query => '', 
      :stats => index_stats
    }
  }
end

get '/orcid/activity' do
  if signed_in?
    haml :activity, :locals => {
      :page => {
        :query => '',
        :branding => settings.crmds_branding
      }
    }
  else
    redirect '/'
  end
end

get '/orcid/claim' do
  status = 'oauth_timeout'

  if signed_in? && params['doi']
    doi = params['doi']
    plain_doi = to_doi(doi)
    orcid_record = settings.orcids.find_one({:orcid => sign_in_id})
    already_added = !orcid_record.nil? && orcid_record['locked_dois'].include?(plain_doi)

    if already_added
      status = 'ok'
    else
      # TODO escape DOI characters
      params = {
        :q => "doi:\"#{doi}\"",
        :fl => '*'
      }
      result = settings.solr.paginate 0, 1, settings.solr_select, :params => params
      doi_record = result['response']['docs'].first

      if !doi_record
        status = 'no_such_doi'
      else
        if OrcidClaim.perform(session_info, doi_record)
          if orcid_record
            orcid_record['updated'] = true
            orcid_record['locked_dois'] << plain_doi
            orcid_record['locked_dois'].uniq!
            settings.orcids.save(orcid_record)
          else
            doc = {:orcid => sign_in_id, :dois => [], :locked_dois => [plain_doi]}
            settings.orcids.insert(doc)
          end

          # The work could have been added as limited or public. If so we need
          # to tell the UI.
          OrcidUpdate.perform(session_info)
          updated_orcid_record = settings.orcids.find_one({:orcid => sign_in_id})

          if updated_orcid_record['dois'].include?(plain_doi)
            status = 'ok_visible'
          else
            status = 'ok'
          end
        else
          status = 'oauth_timeout'
        end
      end
    end
  end

  content_type 'application/json'
  {:status => status}.to_json
end

get '/orcid/unclaim' do
  if signed_in? && params['doi']
    doi = params['doi']
    plain_doi = to_doi(doi)
    orcid_record = settings.orcids.find_one({:orcid => sign_in_id})

    if orcid_record
      orcid_record['locked_dois'].delete(plain_doi)
      settings.orcids.save(orcid_record)
    end
  end

  content_type 'application/json'
  {:status => 'ok'}.to_json
end

get '/orcid/sync' do
  status = 'oauth_timeout'

  if signed_in?
    if OrcidUpdate.perform(session_info)
      status = 'ok'
    else
      status = 'oauth_timeout'
    end
  end

  content_type 'application/json'
  {:status => status}.to_json
end

get '/dois' do
  settings.ga.event('API', '/dois', query_terms, nil, true)
  solr_result = select(search_query)
  items = search_results(solr_result).map do |result|
    {
      :doi => result.doi,
      :score => result.score,
      :normalizedScore => result.normal_score,
      :title => result.coins_atitle,
      :fullCitation => result.citation,
      :coins => result.coins,
      :year => result.coins_year
    }
  end

  content_type 'application/json'

  if ['true', 't', '1'].include?(params[:header])
    page = {
      :totalResults => solr_result['response']['numFound'],
      :startIndex => solr_result['response']['start'],
      :itemsPerPage => query_rows,
      :query => {
        :searchTerms => params['q'],
        :startPage => query_page
      },
      :items => items
    }

    JSON.pretty_generate(page)
  else
    JSON.pretty_generate(items)
  end
end

post '/links' do
  page = {}

  begin
    citation_texts = JSON.parse(request.env['rack.input'].read)

    if citation_texts.count > MAX_MATCH_TEXTS
      page = {
        :results => [],
        :query_ok => false,
        :reason => "Too many citations. Maximum is #{MAX_MATCH_TEXTS}"
      }
    else
      results = citation_texts.take(MAX_MATCH_TEXTS).map do |citation_text|
        terms = scrub_query(citation_text, true)

        if terms.strip.empty?
          {
            :text => citation_text,
            :reason => 'Citation text contains no characters or digits',
            :match => false
          }
        else
          params = {:q => terms, :fl => 'doi,score'}
          result = settings.solr.paginate 0, 1, settings.solr_select, :params => params
          match = result['response']['docs'].first

          if citation_text.split.count < MIN_MATCH_TERMS
            {
              :text => citation_text,
              :reason => 'Too few terms',
              :match => false
            }
          elsif match['score'].to_f < MIN_MATCH_SCORE
            {
              :text => citation_text,
              :reason => 'Result score too low',
              :match => false
            }
          else
            {
              :text => citation_text,
              :match => true,
              :doi => match['doi'],
              :score => match['score'].to_f
            }
          end
        end
      end

      page = {
        :results => results,
        :query_ok => true
      }
    end
  rescue JSON::ParserError => e
    page = {
      :results => [],
      :query_ok => false,
      :reason => 'Request contained malformed JSON'
    }
  rescue Exception => e
    page = {
      :results => [],
      :query_ok => false,
      :reason => e.message
    }
  end

  settings.ga.event('API', '/links', nil, page[:results].count, true)

  content_type 'application/json'
  JSON.pretty_generate(page)
end

get '/citation' do
  citation_format = settings.citation_formats[params[:format]]

  res = settings.data_service.get do |req|
    req.url "/#{params[:doi]}"
    req.headers['Accept'] = citation_format
  end

  settings.ga.event('Citations', '/citation', citation_format, nil, true)

  content_type citation_format
  res.body if res.success?
end

get '/auth/orcid/callback' do
  session[:orcid] = request.env['omniauth.auth']
  Resque.enqueue(OrcidUpdate, session_info)
  update_profile
  haml :auth_callback
end

get '/auth/orcid/import' do
  make_and_set_token(params[:code], settings.orcid_import_callback)
  OrcidUpdate.perform(session_info)
  update_profile
  redirect to("/?q=#{session[:orcid][:info][:name]}")
end

# Used to sign out a user but can also be used to mark that a user has seen the
# 'You have been signed out' message. Clears the user's session cookie.
get '/auth/signout' do
  session.clear
  redirect(params[:redirect_uri])
end

get '/heartbeat' do
  content_type 'application/json'

  params['q'] = 'fish'

  begin
    # Attempt a query with solr
    solr_result = select(search_query)

    # Attempt some queries with mongo
    result_list = search_results(solr_result)

    {:status => :ok}.to_json
  rescue StandardError => e
    {:status => :error, :type => e.class, :message => e}.to_json
  end
end

