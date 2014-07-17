# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require 'coffee_script'
Dir["lib/*.rb"].each { |file| require_relative file }

helpers do
  include RenderingConcerns, APIData, QueryParams, Facets

  def results(funder, works)
    works['items'].map { |item| SearchResult.new item }
  end

  def pagination(works)
    Paginate.new(query_page, query_rows, works['total-results'])
  end

  def page(funder, works)
    { nesting:       funder['hierarchy'],
      nesting_names: funder['hierarchy-names'],
      funder_id:     funder['id'],
      bare_query:    funder['name'],
      page:          query_page,
      items:         results(funder, works),
      paginate:      pagination(works),
      facets:        generate_facets(works) }
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
