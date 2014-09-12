# -*- coding: utf-8 -*-
require 'csv'

class SearchResult

  attr_reader :year, :month, :day
  attr_reader :title, :volume, :issue
  attr_reader :short_publication, :long_publication
  alias_method :publication, :long_publication
  attr_reader :first_page, :last_page
  attr_reader :type, :url, :score
  attr_reader :funders
  attr_reader :authors
  attr_reader :doi

  ENGLISH_MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

  def initialize item
    @url = item['URL']
    @type = item['type'].sub('-', ' ').capitalize
    @score = item['score']
    publications = item['container-title'].sort_by(&:length)
    @short_publication, @long_publication = publications.first, publications.last
    @title = item['title'][0]
    @year, month, @day = item['issued']['date-parts'][0]
    @month = ENGLISH_MONTHS[month - 1] if month
    @volume = item['volume']
    @issue = item['issue']
    @authors = if item['author']
                 item['author'].map { |author| author_full_name(author) }
               else
                 []
               end
    @first_page, @last_page = item['page'].split("-") if item['page']
    # TODO: remove this temporary workaround for a missing funder block when fixed
    #   (item['funder'] || []) -> item['funder']
    @funders = (item['funder'] || []).map { |funder| funder['name'] }
    #@funders = [100000161, "National Institute of Standards and Technologies"]
    @doi = item['DOI']
  end

  def self.generate_csv(results)
    CSV.generate do |csv|
      csv << ['DOI', 'Type', 'Year', 'Title', 'Publication', 'Authors', 'Funders']
      results.each do |result|
        csv << [result.doi, result.type, result.year, result.title, result.publication,
          result.authors.join(', '), result.funders.join(', ')]
      end
    end
  end

  private
    def author_full_name(author)
      "#{author['family']} #{author['given']}"
    end
end
