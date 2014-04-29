require 'time'
require 'open-uri'

# doc = Nokogiri::HTML(File.open('./gotobus.html'))

class Scraper

  attr_accessor :url, :date

  def fetch

    doc = Nokogiri::HTML(open(@url))
    date = doc.css('li[class="active_bus_nav"]').text

    departure_table = doc.css('ul[class="no_list_style bus_depstop"]')
    arrival_table = doc.css('ul[class="no_list_style bus_arrstop"]')

    schedules = []

    for entry in 0...arrival_table.size do
      departure_location = departure_table[entry].css('input').attribute('ivy_address').text
      arrival_location  = arrival_table[entry].css('input').attribute('ivy_address').text
    # t.string   "departure_date"
    # t.string   "departure_time"
    # t.string   "departure_location"
    # t.string   "arrival_date"
    # t.string   "arrival_time"
    # t.string   "arrival_location"
    # t.string   "duration"
    # t.datetime "created_at"
    # t.datetime "updated_at"
      schedule = Schedule.new(
        departure_date: date,
        departure_location: departure_location,
        arrival_location: arrival_location,
        arrival_date: date)
      schedules << schedule
    end

    return schedules
  end


end


class GotoBus < Scraper
  def search_url
    # base_url + date + from_to
    # particular format for GotoBus
  end
end
