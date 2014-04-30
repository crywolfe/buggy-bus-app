require 'nokogiri'
require 'time'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :url, :schedules

  def initialize
    @base_url = "http://search.gotobus.com/search/bus.do"
    @schedules = []
  end

  def make_query

  end

  def commit_schedules

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

  def parse
    self.fetch_html
    for entry in 0...@departure_table.length do
      self.get_departure(entry)
      self.get_arrival(entry)
      self.get_price(entry)
      self.get_company(entry)
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
    @price = @prices[entry].text.slice(/\d+/).to_i
  end

  def get_company(entry)
    # Return company text from appropriate HTML node
    @company = @companies[entry].css('td')[2].text
  end

end

#   def fetch

#     # doc = Nokogiri::HTML(File.open('./gotobus.html'))
#     # doc = Nokogiri::HTML(open(@url))
#     self.fetch_html
#     # prices = doc.css('span[pricecontent]')

#     date = @doc.css('li[class="active_bus_nav"]').text

#     # Declare the parent DOM node which
#     # contains all relevant data
#     departure_table = @doc.css('ul[class="no_list_style bus_depstop"]')
#     arrival_table = @doc.css('ul[class="no_list_style bus_arrstop"]')

#     schedules = []

#     for entry in 0...arrival_table.size do
#       ## Iterate through DOM nodes to capture data
#       departure_location = departure_table[entry].css('input').attribute('ivy_address').text.gsub('&apos;', "'")
#       departure_time = departure_table[entry].css('li input').attribute('value').text.slice(/\d+:\d+[apm]+/)

#       arrival_location  = arrival_table[entry].css('input').attribute('ivy_address').text.gsub('&apos;', "'")
#       arrival_time = arrival_table[entry].css('li input').attribute('value').text.slice(/\d+:\d+[apm]+/)

#       company = @doc.css('table[name="table_radselect"] tr')[entry].css('td')[2].text
#       price = prices[entry].text.slice(/\d+/).to_i
#       # binding.pry
#       schedule = {
#         price: price,
#         departure_location: departure_location,
#         departure_date: date,
#         departure_time: departure_time,
#         arrival_location: arrival_location,
#         arrival_time: arrival_time,
#         arrival_date: date,
#         company_id: company
#       }
#       schedules << schedule
#     end
#     binding.pry
#     return schedules
#   end
# end


############### Notes ##################
#--------------------------------------#

###!!!! Fetch method is TOO long
###!!!! should separate the capture of different
###!!!! data into different instance methods

# Code to parse time into easier to save format
# --- Can be used with departure time and duration
# --- to determine edge cases where the day changes
# --- during the trip
# Time.parse("#{test[:arrival_time]} #{test[:arrival_date]}")

# Code to present time objects in useful to display stringified manner
# some_sample_time_object.strftime("%a, %b %d") --> "Wed, Apr 30"


# doc.css('table[name="table_radselect"] tr')[1].css('td')[2].text


### Possible inheritance??
### BASE_URI is saved to

# class GotoBus < Scraper
#   def search_url
#     # base_url + date + from_to
#     # particular format for GotoBus
#   end
# end
