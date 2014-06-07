require 'nokogiri'

User.delete_all
Company.delete_all
Review.delete_all
Schedule.delete_all

cities = ['philadelphia', 'washington', 'baltimore', 'new york', 'richmond', 'hampton', 'boston']

i = 0
day = Time.now.strftime("%Y/%-m/%-d")
while i < 6 do

  mega = MegabusScraper.new
  goto = GotobusScraper.new

  cities.each do |city|
    mega.build_query(day, 'new york', city)
    mega.parse
    mega.commit_schedules

    goto.build_query(day, 'new york', city)
    goto.parse
    goto.commit_schedules

  end

  day = day.next
  i += 1
end
