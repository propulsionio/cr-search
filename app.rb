# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
Dir["lib/*.rb"].each { |file| require_relative file }

helpers do
  include RenderingConcerns, APIData, QueryParams

    funder_info = { nesting: funder['hierarchy'],
                    nesting_names: funder['hierarchy-names'],
                    id: funder['id'] }
    { funder: funder_info,
  def results(funder, works)
    SearchResult.results_from_items(works['items'], funder['hierarchy-names'])
  end
  def page(funder, works)
      bare_query: funder['name'],
      query: funder['name'],
      page: query_page,
      items: results(funder, works),
      paginate: Paginate.new(query_page, query_rows, works['total-results']),
      facets: ['category', 'type', 'year', 'publication', 'publisher', 'source'] }
  end
end

get '/' do
  if params.has_key?('q')
    funder = funder_hash(params['q'])
    works = funder_works_hash(params['q'], params)

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
