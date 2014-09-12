require 'json'
require 'uri'
require 'net/http'

module APIData
  API_VERSION = 1
  API_URL = "http://api.crossref.org/v#{API_VERSION}"
  CHORUS_MEMBERS = [15, 16, 78, 179, 221, 221, 263, 286, 292, 301, 311, 316, 317, 320]

  def funder_hash(id)
    url = "#{API_URL}/funders/100000161"
    get_message(url)
  end

  def funder_works_hash(id)
    offset = (query_page - 1) * query_rows
    url = "#{API_URL}/funders/100000161/works?facet=t&rows=#{query_rows}"
    url << "&offset=#{offset}" if offset != 0
    url << "&sort=#{params[:sort]}" if params[:sort]
    url << filters
    get_message(url)
  end

  def fetch_us_only_funders(funder_ids_api_uri)
    uri = URI(funder_ids_api_uri)
    Net::HTTP.get(uri)
  end

  private
    def filters
      facets = Facets::FACETS_MAPPING.keys.select { |key| params.has_key? key }
      filters = CHORUS_MEMBERS.map { |member| "member:#{member}" }
      filters << "from-pub-date:#{params[:year]},until-pub-date:#{params[:year]}" if facets.delete 'year'
      filters << facets.map { |facet| "#{Facets::FACETS_MAPPING[facet]}:#{CGI.escape(params[facet])}" } if facets.any?
      "&filter=#{filters.join(',')}"
    end

    def get_message(url)
      puts url
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      JSON(response.body)['message']
    end
end
