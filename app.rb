# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require 'useragent'

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

Browser = Struct.new(:browser, :version)
SupportedBrowsers = [
  Browser.new("Chrome", "18.0"),
]

get '/' do
  user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
  detected = SupportedBrowsers.detect { |browser| user_agent >= browser }

  if params.has_key?('q')
    funder = funder_hash(params['q'])
    works = funder_works_hash(params['q'])


    if params['format'] == 'csv'
      content_type 'text/csv'
      SearchResult.generate_csv results(funder, works)
    else
      haml :results, locals: { page: page(funder, works),
                               browser_detected: detected,
                               supported_browsers: SupportedBrowsers}
    end
  else
    haml :splash, locals: { page: {},
                            browser_detected: detected,
                            supported_browsers: SupportedBrowsers}
  end
end
