require 'spec_helper'

describe MegaBusScraper do
  let(:scraper) { MegaBusScraper.new}
  it "scrap megabus.com of that sweet sweet data" do
    scraper.url = 'spec/test_sources/megabus_results.html'
    results = scraper.parse
    expect(results).to be_a Array
    # expect(results.first).to be_an_instance_of Schedule
  end
end
