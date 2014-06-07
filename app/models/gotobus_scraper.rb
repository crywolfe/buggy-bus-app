require 'time'
require 'open-uri'
require 'rack'

class GotobusScraper

  attr_accessor :url, :schedules

  def initialize
    @base_url = "http://search.gotobus.com/search/bus.do?"
    @schedules = []
    @city_hash = {
      'philadelphia' => 'Philadelphia, PA',
      'washington'   => 'Washington, DC',
      'baltimore'    => 'Baltimore, MD',
      'new york'     => 'New York, NY',
      'richmond'     => 'Richmond, VA',
      'hampton'      => 'Hampton, VA',
      'boston'       => 'Boston, MA'
    }
  end

  def build_query(dep_date, from_city, to_city)
    dep_date = dep_date.gsub('/', '-' )
    query_string = Rack::Utils.build_query({
      'is_roundtrip' => '0',
      'bus_from'     => @city_hash[from_city.downcase],
      'bus_to'       => @city_hash[to_city.downcase],
      'filter_date'  => dep_date
      })
    @url = @base_url + query_string
  end

  def commit_schedules
    @schedules.each do |route_hash|
      route_hash.save
    end
  end

  def company_check
    if Company.find_by(company_name: @company)
      @company_id = Company.find_by(company_name: @company, base_url: @base_url).id
    else
      @company_id = Company.create(company_name: @company, base_url: @base_url).id
    end
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
        company_name:       @company,
        price:              @price,
        link:               @url
      })
    end
    return @schedules
  end

  def fetch_html
    # Load document using Nokogiri and open-uri
    # save to instance variables the arrays of data
    # to be iterated through for data capture
    @doc = Nokogiri::HTML(open(@url))
    @departure_date  = Time.parse(@doc.css('li[class="active_bus_nav"]').text).strftime("%Y/%-m/%-d")
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
    if arrival_hour < departure_hour
      next_day      = (Time.parse(@departure_date) + 86400).strftime("%Y/%-m/%-d")
      @arrival_date = next_day
    elsif
      @arrival_date = Time.parse(@departure_date).strftime("%Y/%-m/%-d")
    end
  end

end
