# require 'nokogiri'
require 'time'
require 'open-uri'
# require 'pry'

class MegaBusScraper

  attr_accessor :url, :schedules

  def initialize
    @schedules = []
  end

  def parse
    @doc = Nokogiri::HTML(open(@url))
    @departure_date = Time.parse(@doc.css('.search_params strong')[1].text).strftime("%a, %b %d")
    @result_tables = @doc.css('ul[class="journey standard none"]')

    @result_tables.each do |entry|
      # this bunch of gook returns a string of text in the following format
      # "Departs 5:00 AM Washington DC Union Station Arrives 9:40 AM New York NY 7th Ave & 28th St"
      route_string = entry.css('li.two p').text.split(/\s+|,|\./).delete_if {|char| char == '' }.join(' ')

      # this bunch of shit returns the following
      # [0] "5:00 AM Washington DC Union Station ", ## departure string
      # [1] "9:40 AM New York NY 7th Ave & 28th St" ## arrival string
      route_array = route_string.gsub('&apos;', "'").split(/Departs\s|Arrives\s/).reject(&:empty?)

      departure_string = route_array[0].strip
      arrival_string = route_array[1].strip

      # this returns just the string of time
      # as such "5:00 AM"
      # step3 = step2[0][/\d+:\d+\S[amp]+/i]

      # alternate step2 provides this
      # [0] "9:40 AM",
      # [1] " New York NY 7th Ave & 28th St"
      departure_data_array = departure_string.gsub(/\./, '').partition(/\d+:\d+\S[amp]+/i)
      departure_data_array.delete_at(0)

      arrival_data_array = arrival_string.gsub(/\./, '').partition(/\d+:\d+\S[amp]+/i)
      arrival_data_array.delete_at(0)

      @departure_location = departure_data_array[1].strip
      @departure_time = departure_data_array[0].strip

      @arrival_location = arrival_data_array[1].strip
      @arrival_time = arrival_data_array[0].strip

      @company = "Megabus"
      @price = entry.css('li.five p').text[/\$\d+\.\d{2}/]

      self.calculate_arrival_date

      @schedules << {
        departure_location: @departure_location,
        departure_date:     @departure_date,
        departure_time:     @departure_time,
        arrival_location:   @arrival_location,
        arrival_time:       @arrival_time,
        arrival_date:       @arrival_date,
        company_id:         @company,
        price:              @price
      }
    end
      binding.pry
    return @schedules
  end

  def calculate_arrival_date
    # Determine arrival date by comparing departure
    # and arrival times. Change or keep date as necessary.
    departure_hour = Time.parse(@departure_time).hour
    arrival_hour   = Time.parse(@arrival_time).hour
    if arrival_hour < departure_hour
      next_day      = (Time.parse(@departure_date) + 86400).strftime("%a, %b %d")
      @arrival_date = next_day
    elsif
      @arrival_date = @departure_date
    end
  end
end
