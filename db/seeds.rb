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

# # Megabus is company_id 1
# # ChinaBus is company_id 2
# # Bolt is company_id 3
# # Greyhound is company 4
# # Peter Pan is company 5

# #Create Users --------------------------

# taylor_swift = User.create({
#   name: "Taylor Swift",
#   email: "taylor@swift.com",
#   password: "password"
#   })

# j_edgar = User.create({
#   name: "J Edgar Hoover",
#   email: "j@hoover.com",
#   password: "password"
#   })

# iggy_azalea = User.create({
#   name: "Iggy Azalea",
#   email: "iggy@azalea.com",
#   password: "password"
#   })

# cody_banks = User.create({
#   name: "Agent Cody Banks",
#   email: "cody@banks.com",
#   password: "password"
#   })

# harrison_ford = User.create({
#   name: "Harrison Ford",
#   email: "harrison@ford.com",
#   password: "password"
#   })

# steve_mcqueen = User.create({
#   name: "Steve McQueen",
#   email: "steve@mcqueen.com",
#   password: "password"
#   })

# tanya_harding = User.create({
#   name: "Tanya Harding",
#   email: "tanya@harding.com",
#   password: "password"
#   })

# dave_chapelle = User.create({
#   name: "Dave Chapelle",
#   email: "dave@chapelle.com",
#   password: "password"
#   })

# general_tso = User.create({
#   name: "General Tso",
#   email: "general@tso.com",
#   password: "password"
#   })

# bette_davis = User.create({
#   name: "Bette Davis",
#   email: "bette@davis.com",
#   password: "password"
#   })

# admin = User.create({
#   name: "Admin",
#   email: "admin@admin.com",
#   password: "password",
#   admin: "true"
#   })


# #Create Reviews --------------------------

# #Megabus
# Review.create({
#   post: "Mega Bus more like Mega-lame-o bus, enough said.",
#   date: "1/5/2020",
#   rating: 1,
#   like: 0,
#   user_id: 1,
#   company_id: 1
#   })

# #Chinabus
# Review.create({
#     post: "Chinabus rocks my socks bro.",
#     date: "1/5/2030",
#     rating: 4,
#     like: 3,
#     user_id: 2,
#     company_id: 2
#   })

# #Bolt bus
# Review.create({
#   post: "I love Bolt Bussssss!!! But the guy next to me was so weird lolz. ",
#   date: "1/5/2010",
#   rating: 4,
#   like: 6,
#   user_id: 3,
#   company_id: 3
#   })

# #Greyhound
# Review.create({
#   post: "I met my wife on Greyhound, ps she's super hawt",
#   date: "1/19/2020",
#   rating: 5,
#   like: 4,
#   user_id: 4,
#   company_id: 4
#   })

# #Peter Pan
# Review.create({
#   post: "I lost my v-card to Pieter Pan, don't tell my boyfriend Hansel",
#   date: "5/5/3020",
#   rating: 3,
#   like: 96,
#   user_id: 5,
#   company_id: 5
#   })

# #Create Schedules -----------------------------------

# #Megabus
# Schedule.create({
#   departure_date: "01/01/1994",
#   departure_time: "3:00 am",
#   departure_location: "NYC",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:00 pm",
#   arrival_location: "Boston",
#   duration: "3h",
#   company_id: 1
#   })

# #china bus
# Schedule.create({
#   departure_date: "05/05/1994",
#   departure_time: "3:15 am",
#   departure_location: "NYC",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:45 pm",
#   arrival_location: "Boston",
#   duration: "3h",
#   company_id: 2
#   })
# #bolt bus
# Schedule.create({
#   departure_date: "05/05/1994",
#   departure_time: "3:30 am",
#   departure_location: "NYC",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:45 pm",
#   arrival_location: "Hampton",
#   duration: "3h 15m",
#   company_id: 3
#   })


# #bolt bus
# Schedule.create({
#   departure_date: "05/05/1994",
#   departure_time: "3:55 am",
#   departure_location: "NYC",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:55 pm",
#   arrival_location: "Richmond",
#   duration: "3h",
#   company_id: 3
#   })

# #bolt bus
# Schedule.create({
#   departure_date: "05/05/1994",
#   departure_time: "6:00 am",
#   departure_location: "NYC",
#   arrival_date: "5/5/1994",
#   arrival_time: "9:00 pm",
#   arrival_location: "Baltimore",
#   duration: "3h",
#   company_id: 3
#   })

# #greyhound
# Schedule.create({
#   departure_date: "05/05/1994",
#   departure_time: "6:00 am",
#   departure_location: "NYC",
#   arrival_date: "5/5/1994",
#   arrival_time: "9:53 pm",
#   arrival_location: "Philadelphia",
#   duration: "3h 53m",
#   company_id: 4
#   })

# #Peter Pan
#  Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })

#    Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })

#    Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })

#   Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })

#   Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })

#   Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })

#   Schedule.create({
#   departure_date: "2014/5/1",
#   departure_time: "8:30 PM",
#   departure_location: "Washington DC Union Station",
#   arrival_date: "5/5/1994",
#   arrival_time: "6:53 pm",
#   arrival_location: "New York NY 7th Ave & 28th St",
#   duration: "6h 1m",
#   company_id: 5
#   })


# #Create Companies --------------------

# mega_bus = Company.create({
#   company_name: "Mega Bus",
#   base_url: "https://us.megabus.com/Default.aspx",
#   })

# china_bus = Company.create({
#   company_name: "China Bus",
#   base_url: "http://www.gotobus.com/bus-tickets/",
#   })

# bolt_bus = Company.create({
#   company_name: "Bolt Bus",
#   base_url: "https://www.boltbus.com/",
#   })

# greyhound = Company.create({
#   company_name: "Greyhound",
#   base_url: "https://www.greyhound.com/",
#   })

# peter_pan = Company.create({
#   company_name: "Peter Pan",
#   base_url: "http://peterpanbus.com/",
#   })


