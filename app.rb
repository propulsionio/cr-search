# -*- coding: utf-8 -*-
require 'sinatra'
require 'json'
require 'haml'
require 'will_paginate'
require 'cgi'
require 'faraday'
require 'faraday_middleware'
require 'haml'
require 'open-uri'
require 'uri'
require 'csv'

require_relative 'lib/paginate'
require_relative 'lib/result'
require_relative 'lib/bootstrap'
require_relative 'lib/doi'

MIN_MATCH_SCORE = 2
MIN_MATCH_TERMS = 3
MAX_MATCH_TEXTS = 1000

after do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

configure do
  end


  # Configure solr
  set :solr, RSolr.connect(:url => settings.solr_url)


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
  set :facet_fields, ['type', 'year', 'oa_status', 'publication', 'category', 'publisher', 'funder_name', 'source']
  set :crmds_facet_fields, ['type', 'year', 'oa_status', 'publication', 'category', 'publisher', 'funder_name', 'source']
  set :fundref_facet_fields, ['type', 'year', 'oa_status', 'publication', 'category', 'publisher', 'source']
  set :chorus_facet_fields, ['category', 'type', 'year', 'publication', 'publisher', 'source']

  # Google analytics event tracking
  set :ga, Gabba::Gabba.new('UA-34536574-2', 'http://search.labs.crossref.org')


  set :test_prefixes, ["10.5555", "10.55555"]
end

helpers do
  include Doi
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
    query_params[:rows] = 60000000
    query_params[:page] = 0
    results = settings.solr.get settings.solr_select, :params => query_params
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
    terms = query_terms || '*:*'
    query = base_query.merge({:q => terms})

    fq = facet_query
    query['fq'] = fq unless fq.empty?
    query
  end

  def fundref_doi_query funder_dois, prefixes

    doi_q = funder_dois.map {|doi| "funder_doi:\"#{doi}\""}.join(' OR ')
    query = base_query.merge({:q => doi_q})

    if prefixes
      prefixes = prefixes.map {|prefix| "http://id.crossref.org/prefix/#{prefix}"}
      prefix_q = prefixes.map {|prefix| "owner_prefix:\"#{prefix}\""}.join(' OR ')
      query[:q] = "(#{query[:q]}) AND (#{prefix_q})"
    end
      
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

  def fundref_csv_link id
    "/fundref.csv?q=#{id}&format=csv"
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

  def result_publication_date record
    year = record['hl_year'].to_i
    month = record['month'] || 1
    day = record['day'] || 1
    Date.new(year, month, day)
  end

  def scrub_query query_str, remove_short_operators
    query_str = query_str.gsub(/[{}*\"\.\[\]\(\)\-:;\/%^&]/, ' ')
    query_str = query_str.gsub(/[\+\!\-]/, ' ') if remove_short_operators
    query_str = query_str.gsub(/AND/, ' ')
    query_str = query_str.gsub(/OR/, ' ')
    query_str.gsub(/NOT/, ' ')

    if query_str.gsub(/[\+\!\-]/,'').strip.empty?
      nil
    else
      query_str
    end
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

  def render_funders_full_children indent, current_id, children_map, names, &block
    block.call(indent, current_id, names[current_id])
    
    if !children_map[current_id].nil?
      children_map[current_id].each do |c|
        render_funders_full_children(indent + 1, c[:id], children_map, names, &block)
      end
    end
  end

  def render_funders_full id, indent, &block
    funder = settings.funders.find_one({:id => id})
    names = funder['descendant_names']
    names[id] = funder['primary_name_display']

    descendants = funder['descendants'].map do |d_id|
      d = settings.funders.find_one({:id => d_id})
      {:id => d_id, :parent => d['parent']}
    end

    children = descendants.reduce({}) do |memo, d|
      memo[d[:parent]] ||= []
      memo[d[:parent]] << d
      memo
    end

    render_funders_full_children(indent, id, children, names, &block)
  end

  def funder_doi_from_id id
    dois = ["http://dx.doi.org/10.13039/#{id}"]

    dois += settings.funders.find_one({:id => id})['descendants'].map do |id|
      "http://dx.doi.org/10.13039/#{id}"
    end
  end

  def test_doi? doi
    plain_doi = to_doi(doi)
    plain_doi.start_with?('10.5555') || plain_doi.start_with?('10.55555')
  end

  def index_stats
    loc = settings.solr_select

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
      :q => 'funder_name:[* TO *] OR funder_doi:[* TO *] OR hl_grant:[* TO *] -hl_grant:""',
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

helpers do
  def handle_fundref branding
    prefixes = branding[:filter_prefixes]

    if !params.has_key?('q')
      haml :splash, :locals => {:page => {:branding => branding}}
    elsif params.has_key?('format') && params['format'] == 'csv'
      funder_dois = funder_doi_from_id(params['q'])
      solr_result = select_all(fundref_doi_query(funder_dois, prefixes))
      results = search_results(solr_result)

      csv_response = CSV.generate do |csv|
        csv << ['DOI', 'Type', 'Year', 'Title', 'Publication', 'Authors', 'Funders', 'Awards']
        results.each do |result|
          csv << [result.doi, 
                  result.type,
                  result.coins_year, 
                  result.coins_atitle,
                  result.coins_title,
                  result.coins_authors,
                  result.plain_funder_names,
                  result.award_numbers
                  ]
        end
      end

      content_type 'text/csv'
      csv_response
    else
      funder_dois = funder_doi_from_id(params['q'])
      solr_result = select(fundref_doi_query(funder_dois, prefixes))
      funder = settings.funders.find_one({:uri => funder_dois.first})
      funder_info = {
        :nesting => funder['nesting'], 
        :nesting_names => funder['nesting_names'],
        :id => funder['id']
      }
      page = result_page(solr_result)

      page[:bare_query] = funder['primary_name_display']
      page[:query] = scrub_query(page[:bare_query], false)

      haml :results, :locals => {
        :page => {
          :branding => branding,
          :funder => funder_info
        }.merge(page)
      }
    end
  end

  def resolve_references citation_texts
    page = {}
    begin
      if citation_texts.count > MAX_MATCH_TEXTS
        page = {
          :results => [],
          :query_ok => false,
          :reason => "Too many citations. Maximum is #{MAX_MATCH_TEXTS}"
        }
      else
        results = Parallel.map(citation_texts.take(MAX_MATCH_TEXTS),
                               :in_processes => settings.links_process_count) do |citation_text|
          terms = scrub_query(citation_text, true)

          if terms.strip.empty?
            {
              :text => citation_text,
              :reason => 'Citation text contains no characters or digits',
              :match => false
            }
          else
            params = base_query.merge({:q => terms, :rows => 1})
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
                :coins => search_results(result).first.coins,
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
        :reason => e.message,
        :trace => e.backtrace
      }
    end

    page
  end
end

end

get '/citation' do
  citation_format = settings.citation_formats[params[:format]]

  res = settings.data_service.get do |req|
    req.url "/#{params[:doi]}"
    req.headers['Accept'] = citation_format
  end

  content_type citation_format
  res.body if res.success?
end
