class Search < ActiveRecord::Base
  include MegabusScraper
  include GotobusScraper

  def collect(dep_date, dep_location, arrival_location)
    day = Time.now.strftime("%Y/%-m/%-d")

    mega = MegabusScraper.new
    goto = GotobusScraper.new

    mega.build_query(dep_date, dep_location, arrival_location)
    goto.build_query(dep_date, dep_location, arrival_location)

    unified_results = goto.parse + mega.parse

    return unified_results
  end

end
