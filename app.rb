# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
Dir["lib/*.rb"].each { |file| require_relative file }

helpers do
  include RenderingConcerns, APIData, QueryParams

  def page(funder, results, total_results)
    funder_info = { nesting: funder['hierarchy'],
                    nesting_names: funder['hierarchy-names'],
                    id: funder['id'] }
    { funder: funder_info,
      bare_query: funder['name'],
      query: funder['name'],
      page: query_page,
      items: results,
      paginate: Paginate.new(query_page, query_rows, total_results),
      facets: ['category', 'type', 'year', 'publication', 'publisher', 'source'] }
  end
end

get '/' do
  if params.has_key?('q')
    funder = funder_hash(params['q'])
    works = funder_works_hash(params['q'], params)
    results = SearchResult.results_from_items(works['items'], funder['hierarchy-names'])

    if params['format'] == 'csv'
      content_type 'text/csv'
      SearchResult.generate_csv(results)
    else
      haml :results, locals: { page: page(funder, results, works['total-results']) }
    end
  else
    haml :splash, locals: { page: {} }
  end
end
