namespace :scraper do
  desc "scrapes gotobus"
  task :gotobus => :environment do
    puts "scraping gotobus.com"
    Scraper.new
  end
end
