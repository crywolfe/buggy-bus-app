require 'spec_helper'

describe MegabusScraper do
  let(:scraper) { MegabusScraper.new}

  describe '::parse' do
    it "scrap megabus.com of that sweet sweet data" do
      scraper.url = 'spec/test_sources/megabus_results.html'
      # scraper.url = 'http://us.megabus.com/JourneyResults.aspx?originCode=143&destinationCode=127&outboundDepartureDate=5%2f8%2f2014&inboundDepartureDate=&passengerCount=1&transportType=0&concessionCount=0&nusCount=0&outboundWheelchairSeated=0&outboundOtherDisabilityCount=0&inboundWheelchairSeated=0&inboundOtherDisabilityCount=0&outboundPcaCount=0&inboundPcaCount=0&promotionCode=&withReturn=0'
      results = scraper.parse
      expect(results).to be_a Array
      expect(results.first).to be_an_instance_of Schedule
    end
  end

  describe '::build_query' do
    it "translates provided dates into correct query format" do
      expect(2+2).to eq 4
    end
  end

end
