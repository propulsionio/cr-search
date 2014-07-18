module Funders
  def fetch_children_and_update_funders(funder_id, children_storage, level)
    uri = URI("http://api.crossref.org/funders/10.13039/#{funder_id}")
    response = JSON.parse(Net::HTTP.get(uri))


    funder = { id: funder_id,
               name: response["message"]["name"],
               level: level,
               children: [] }
    children_storage << funder

    children_ids = response["message"]["descendants"]
    children_ids.each do |child_id|
      fetch_children_and_update_funders(child_id, funder[:children], level+1)
    end
  end

  def get_fresh_funders
    top_funder_id = 100000016
    top_level = 0
    funders = []

    fetch_children_and_update_funders(top_funder_id, funders, top_level)

    funders
  end

  def render_fresh_funder funder, &block
    funder[:children].each do |funder|
      block.call(funder[:name], funder[:id], funder[:level])
      render_fresh_funder(funder, &block)
    end
  end

end
