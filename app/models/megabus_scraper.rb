require 'time'
require 'open-uri'
require 'rack'

class MegabusScraper

  attr_accessor :url, :schedules

  def initialize
    @base_url = "http://http://us.megabus.com/JourneyResults.aspx?"
    @schedules = []
  end

  def make_query(dep_date, from_location, to_location)

    ### logic to interpret arugments for
    ### departure and arrival locations
    ### into the matching codes goes HERE


    query_string = Rack::Utils.building_query({
      originCode: ###,
      destinationCode: ###,
      outboundDepartureDate: ##/##/####,
      passengerCount: 1
    })
    return @base_url + query_string
  end

  def commit_schedules
    @schedules.each do |route_hash|
      route_hash.save
    end
  end

  def fetch_html
    @doc = Nokogiri::HTML(open(@url))
    @departure_date = Time.parse(@doc.css('.search_params strong')[1].text).strftime("%a, %b %d")
    @result_tables  = @doc.css('ul[class="journey standard none"]')
  end

  def parse
    self.fetch_html
    @result_tables.each do |entry|
      # this bunch of shit returns a string of text in the following format
      # "Departs 5:00 AM Washington DC Union Station Arrives 9:40 AM New York NY 7th Ave & 28th St"
      route_string = entry.css('li.two p').text.split(/\s+|,|\./).delete_if {|char| char == '' }.join(' ')

      # this other bunch of shit returns the following
      # [0] "5:00 AM Washington DC Union Station ", ## departure string
      # [1] "9:40 AM New York NY 7th Ave & 28th St" ## arrival string
      route_array = route_string.gsub('&apos;', "'").split(/Departs\s|Arrives\s/).reject(&:empty?)

      departure_string = route_array[0].strip
      arrival_string = route_array[1].strip

      # this splits the time and address separately as such
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

      @schedules << Schedule.new({
        departure_location: @departure_location,
        departure_date:     @departure_date,
        departure_time:     @departure_time,
        arrival_location:   @arrival_location,
        arrival_time:       @arrival_time,
        arrival_date:       @arrival_date,
        company_id:         @company,
        price:              @price
      })
    end
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

binding.pry
