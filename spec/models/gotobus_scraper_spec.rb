require 'spec_helper'

describe GotobusScraper do
  let(:scraper) { GotobusScraper.new }
  it "returns an array of schedules" do
    url = 'spec/test_sources/apostrophe_test.html'
    scraper.url = url
    # results = GoToBusScraper.search({date: "2014-04-30", bus_to: "New York", bus_from: "Philadelphia"})
    results = scraper.parse
    expect(results).to be_a Array
    expect(results.first).to be_an_instance_of Schedule
  end

  describe '::build_query' do
    it "translates provided dates into correct query format" do
      url = 'spec/test_sources/apostrophe_test.html'
      scraper.url = url
      query = scraper.build_query('04/30/2014', 'washington', 'baltimore')
      actual_query = "http://search.gotobus.com/search/bus.do?is_roundtrip=0&bus_from=Wilmington%2C+DE&bus_to=Baltimore%2C+MD&filter_date=2014-04-30"
      expect(query).to be actual_query
    end
  end
end
