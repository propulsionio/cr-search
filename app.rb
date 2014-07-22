# -*- coding: utf-8 -*-
require 'sinatra'
require "sinatra/config_file"
require 'haml'
require 'coffee_script'
require 'net/http'

Dir["lib/*.rb"].each { |file| require_relative file }

config_file './config.yml'
funder_ids_api_uri = settings.funders_ids_api

helpers do
  include RenderingConcerns, APIData, QueryParams, Facets

  def results(funder, works)
    works['items'].map { |item| SearchResult.new item }
  end

  def pagination(works)
    Paginate.new(query_page, query_rows, works['total-results'])
  end

  def page(funder, works)
    hierarchy, hierarchy_names = funder['hierarchy'], funder['hierarchy-names']
    page = {}
    # TODO: extract to method
    if params['us-only'] == 't'
      page.merge! us_only: true
      funders = top_level_us_only_funders
      top_level_us_only_funders_nesting = top_level_us_only_funders_nesting(funders)
      if top_level_us_only_funders_nesting.has_key? funder['id']
        if hierarchy.has_key? funder['id']
          top_level_us_only_funders_nesting.merge! funder['id'] => hierarchy[funder['id']]
        elsif hierarchy.first[1].has_key? funder['id']
          top_level_us_only_funders_nesting.merge! funder['id'] => hierarchy.first[1][funder['id']]
        end
      end
      hierarchy = top_level_us_only_funders_nesting
      hierarchy_names.merge! top_level_us_only_funders_nesting_names(funders)
    end
    { nesting:       hierarchy,
      nesting_names: hierarchy_names,
      funder_id:     funder['id'],
      bare_query:    funder['name'],
      page:          query_page,
      items:         results(funder, works),
      paginate:      pagination(works),
      facets:        generate_facets(works) }.merge(page)
  end

  def top_level_us_only_funders_nesting(funders)
    funders.inject({}) do |nesting, funder|
      nesting[funder[:id].to_s] = if funder[:descendants].empty?
                                    {}
                                  else
                                    {"more"=>true}
                                  end
      nesting
    end
  end

  def top_level_us_only_funders_nesting_names(funders)
    funders.inject({}) do |nesting_names, funder|
      nesting_names[funder[:id].to_s] = funder[:name]
      nesting_names
    end
  end
end

get '/' do
  if params.has_key?('q')
    funder = funder_hash(params['q'])
    works = funder_works_hash(params['q'])

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
  uri = URI(funder_ids_api_uri)
  Net::HTTP.get(uri)
end
