module Facets
  FACETS_MAPPING =  { 'category'    => 'category-name',
                      'type'        => 'type-name',
                      'year'        => 'published',
                      'publication' => 'container-title',
                      'publisher'   => 'publisher-name' }

  def generate_facets(works)
    FACETS_MAPPING.keys.inject({}) do |facets, facet_name|
      facet_filter = FACETS_MAPPING[facet_name]
      facets[facet_name] = works['facets'][facet_filter]['values']
      facets
    end
  end
end
