require 'time'
require 'open-uri'
require 'rack'

class GotobusScraper

  attr_accessor :url, :schedules

  def initialize
    @base_url = "http://search.gotobus.com/search/bus.do"
    @schedules = []
  end

  def make_query(dep_date, from_location, to_location)

    ### logic to interpret arugments for
    ### departure and arrival locations
    ### into the matching strings goes HERE

    query_string = Rack::Utils.building_query(
      'placeholder'
      )
    return @base_url + query_string
  end

  def commit_schedules
    @schedules.each do |route_hash|
      route_hash.save
    end
  end

  def company_check

  end

  def parse
    self.fetch_html
    for entry in 0...@departure_table.length do
      self.get_departure(entry)
      self.get_arrival(entry)
      self.get_price(entry)
      self.get_company(entry)
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

  def fetch_html
    # Load document using Nokogiri and open-uri
    # save to instance variables the arrays of data
    # to be iterated through for data capture
    @doc = Nokogiri::HTML(open(@url))
    @departure_date  = @doc.css('li[class="active_bus_nav"]').text
    @departure_table = @doc.css('ul[class="no_list_style bus_depstop"]')
    @arrival_table   = @doc.css('ul[class="no_list_style bus_arrstop"]')
    @companies       = @doc.css('table[name="table_radselect"] tr')
    @prices          = @doc.css('strong[class="cff6"]'); @prices.shift
  end

  def get_arrival(entry)
    # Search through nodes using Nokogiri .css, .attribute, and .text methods
    # .gsub to replace any apostrophes. Save returns to instance variables.
    @arrival_location = @arrival_table[entry].css('input').attribute('ivy_address').text.gsub('&apos;', "'")
    @arrival_time     = @arrival_table[entry].css('li input').attribute('value').text.slice(/\d+:\d+[apm]+/)
  end

  def get_departure(entry)
    # Search through nodes using Nokogiri .css, .attribute, and .text methods
    # gsub to replace any apostrophes. Save returns to instance variables.
    @departure_location = @departure_table[entry].css('input').attribute('ivy_address').text.gsub('&apos;', "'")
    @departure_time     = @departure_table[entry].css('li input').attribute('value').text.slice(/\d+:\d+[apm]+/)
  end

  def get_price(entry)
    # select price and save to instance
    @price = '$' + @prices[entry].text.slice(/\d+/) + '.00'
  end

  def get_company(entry)
    # Return company text from appropriate HTML node
    @company = @companies[entry].css('td')[2].text
  end

  def calculate_arrival_date
    # Determine arrival date by comparing departure
    # and arrival times. Change or keep date as necessary.
    departure_hour = Time.parse(@departure_time).hour
    arrival_hour   = Time.parse(@arrival_time).hour
    # binding.pry
    if arrival_hour < departure_hour
      next_day      = (Time.parse(@departure_date) + 86400).strftime("%a, %b %d")
      @arrival_date = next_day
    elsif
      @arrival_date = @departure_date
    end
  end

end
