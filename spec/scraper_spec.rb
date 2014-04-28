require 'spec_helper'

describe Scraper do
  describe "#fetch" do
    let(:scraper) { Scraper.new }
    it "returns an array of schedules" do
      url = "http://search.gotobus.com/search/bus.do?nm=&st=0&gid=&option=Select&from_vendor_page=&hotel_bus_package=&is_roundtrip=0&submit_flag=submit_flag&roundtrip=0&bus_from=New+York%2C+NY&bus_to=Philadelphia%2C+PA&filter_date=2014-04-30&return_date=&adult_num=1&child_num=0"
      scraper.url = url
      scaper.date = Date.today
      results = scraper.fetch
      expect(results).to be_a Array
      expect(results.first).to be_an_instance_of Schedule
    end
  end
end

# describe GoToBusScraper do
#   describe "::search" do
#     it "returns an array of Schedules" do
#       results = GoToBusScraper.search({date: "2014-04-30", bus_to: "New York", bus_from: "Philadelphia"})
#       expect(results).to be_a Array
#       expect(results.first).to be_an_instance_of Schedule
#     end
#   end
# end
