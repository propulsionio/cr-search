# -*- coding: utf-8 -*-
require 'sinatra'  
require "sinatra/config_file"
require 'haml'
require 'coffee_script'
require 'net/http'
require 'json'
require 'pry'

Dir["lib/*.rb"].each { |file| require_relative file }

config_file './config.yml'
funder_ids_api_uri = settings.funders_ids_api
funder_ids_json_uri = settings.funders_ids_json

helpers do
  include RenderingConcerns, APIData, QueryParams, Facets

  def results(funder, works)
    works['items'].map { |item| SearchResult.new item }
  end

  def pagination(works)
    Paginate.new(query_page, query_rows, works['total-results'])
  end

  def us_only_funders_ids
    @us_only_funders_ids ||= JSON(fetch_us_only_funders(settings.funders_ids_api)).map { |funder| funder['id'].to_s }
  end

  def page(funder, works)
    page = {}
    if params['us-only'] == 't'
      page.merge! us_only: true,
                  us_only_funders_ids: us_only_funders_ids
    end
    { nesting:       funder['hierarchy'],
      nesting_names: funder['hierarchy-names'],
      funder_id:     funder['id'],
      bare_query:    funder['name'],
      page:          query_page,
      items:         results(funder, works),
      paginate:      pagination(works),
      facets:        generate_facets(works) }.merge(page)
  end
end

get '/' do
  if params.has_key?('q')
    funder = funder_hash(params['q'], funder_ids_json_uri)
    works = funder_works_hash(params['q'])
    if params['us-only'] == 't'
      works['items'] = works['items'].select do |item|
        item['funder'].any? do |funder|
          us_only_funders_ids.include?(funder['DOI'].split('/')[1]) if funder['DOI']
        end
      end
    end

    if params['format'] == 'csv'
      content_type 'text/csv'
      SearchResult.generate_csv results(funder, works)
    else
      haml :results, locals: { page: page(funder, works) }
    end
  else
    haml :splash, locals: { page: {} }
  end
end

get '/funders_us.json', provides: :json do
  fetch_us_only_funders(funder_ids_api_uri)
end
