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
end
