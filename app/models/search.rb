class Search < ActiveRecord::Base

  def self.collect(dep_date, dep_location, arrival_location)

    mega = MegabusScraper.new
    goto = GotobusScraper.new

    mega.build_query(dep_date, dep_location, arrival_location)
    goto.build_query(dep_date, dep_location, arrival_location)

    unified_results = goto.parse + mega.parse

    return unified_results
  end

end
