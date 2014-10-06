require 'json'
require 'uri'
require 'net/http'

module APIData
  API_VERSION = 1
  API_URL = "http://api.crossref.org/v#{API_VERSION}"
  CHORUS_MEMBERS = [15, 16, 78, 98, 179, 221, 221, 263, 286, 292, 301, 311, 316, 317, 320]

  def funder_hash(id, funder_ids_url)
    url = "#{API_URL}/funders/#{id}"
    funders = get_message(url)

    parent_id = funders['hierarchy'].keys[0];

    funder_descendants = "";
    funder_ids = JSON.parse(fetch_us_only_funders(funder_ids_url))
    funder_ids.each do |funder|
      if(funder['id'] == parent_id.to_i) then
        funder_descendants = funder
        break
      end
    end

    count_url = "#{API_URL}/funders/10.13039/#{parent_id}/works?rows=0&facet=funder-doi:*"
    count_url << filters
    counts = get_message(count_url);
   
    values = Hash[counts['facets']['funder-doi']['values'].map {|k, v| [k.split("/").last, v]}]

    if(funders['hierarchy'][parent_id] != nil) then
      funders['hierarchy'][parent_id] = update_funder_hierarchy(funders['hierarchy'][parent_id], values, funder_descendants)
    end
    
    funders
  end

  def update_funder_hierarchy(hierarchy, values, funder_descendants)
    hierarchy.each do |key, value|
      
      if(hierarchy[key].empty?) then
        hierarchy[key]['count'] = values[key] || 0;

      elsif(hierarchy[key].has_key?('more')) then
        descendants = []

        if(funder_descendants['descendants'] != nil) then
          funder_descendants['descendants'].each do |descendant|
            if(descendant['id'] == key)
              descendants << descendant
              break
            end
          end
        end       
        
        hierarchy[key]['count'] = evaluate_funder_works_count(descendants, values, 0)

      else
        descendants = []

        if(funder_descendants['descendants'] != nil) then
          funder_descendants['descendants'].each do |descendant|
            if(descendant['id'] == key)
              descendants << descendant
              break
            end
          end
        end
        
        update_funder_hierarchy(hierarchy[key], values, funder_descendants)
        hierarchy[key]['count'] = evaluate_funder_works_count(descendants, values, 0)
      end
    end
  end

  def evaluate_funder_works_count(descendants, values, count = 0)    
    descendants.each do |descendant|
      count += (values[descendant['id']] || 0)
      if(descendant['descendants'].length > 0) then
        count = evaluate_funder_works_count(descendant['descendants'], values, count)
      end
    end

    return count
  end

  def funder_works_hash(id)
    offset = (query_page - 1) * query_rows
    url = "#{API_URL}/funders/#{id}/works?facet=t&rows=#{query_rows}"
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
