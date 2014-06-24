require 'json'
require 'uri'
require 'net/http'

module APIData
  API_VERSION = 1
  API_URL = "http://api.crossref.org/v#{API_VERSION}"

  def funder_hash(id)
    url = "#{API_URL}/funders/#{id}"
    get_message(url)
  end

  def funder_works_hash(id)
    offset = (query_page - 1) * query_rows
    url = "#{API_URL}/funders/#{id}/works?facet=t&rows=#{query_rows}"
    url << "&offset=#{offset}" if offset != 0
    url << "&sort=#{params[:sort]}" if params[:sort]
    url << filters
    get_message(url)
  end

  private
    def filters
      facets = Facets::FACETS_MAPPING.keys.select { |key| params.has_key? key }
      if facets.empty?
        ''
      else
        filters = []
        filters << "from-pub-date:#{params[:year]},until-pub-date:#{params[:year]}" if facets.delete 'year'
        filters << facets.map { |facet| "#{Facets::FACETS_MAPPING[facet]}:#{CGI.escape(params[facet])}" }
        "&filter=#{filters.join(',')}"
      end
    end

    def get_message(url)
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      JSON(response.body)['message']
    end
end
