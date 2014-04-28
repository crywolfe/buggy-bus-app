User.delete_all
Company.delete_all
Review.delete_all
Schedule.delete_all

#Create Users --------------------------

taylor_swift = User.create({
  name: "Taylor Swift",
  email: "taylor@swift.com",
  password: "password"
  })

j_edgar = User.create({
  name: "J Edgar Hoover",
  email: "j@hoover.com",
  password: "password"
  })

iggy_azalea = User.create({
  name: "Iggy Azalea",
  email: "iggy@azalea.com",
  password: "password"
  })

cody_banks = User.create({
  name: "Agent Cody Banks",
  email: "cody@banks.com",
  password: "password"
  })

harrison_ford = User.create({
  name: "Harrison Ford",
  email "harrison@ford.com",
  password: "password"
  })

steve_mcqueen = User.create({
  name: "Steve McQueen",
  email: "steve@mcqueen.com",
  password: "password"
  })

tanya_harding = User.create({
  name: "Tanya Harding",
  email: "tanya@harding.com",
  password: "password"
  })

dave_chapelle = User.create({
  name: "Dave Chapelle",
  email: "dave@chapelle.com",
  password: "password"
  })

general_tso = User.create({
  name: "General Tso",
  email: "general@tso.com",
  password: "password"
  })

bette_davis = User.create({
  name: "Bette Davis",
  email: "bette@davis.com",
  password: "password"
  })

#Create Companies --------------------

mega_bus = Company.create({
  company_name: "Mega Bus",
  base_url: "https://us.megabus.com/Default.aspx"
  })

china_bus = Company.create({
  company_name: "China Bus",
  base_url: "http://www.gotobus.com/bus-tickets/"
  })

bolt_bus = Company.create({
  company_name: "Bolt Bus",
  base_url: "https://www.boltbus.com/"
  })

greyhound = Company.create({
  company_name: "Greyhound",
  base_url: "https://www.greyhound.com/"
  })

peter_pan = Company.create({
  company_name: "Peter Pan",
  base_url: "http://peterpanbus.com/"
  })

#Create Reviews --------------------------

mega_bus_review = Review.create({
  post: "Mega Bus more like Mega-lame-o bus, enough said.",
  date: "1/5/2020",
  rating: 1,
  like: 0
  })

china_bus_review = Review.create({
    post: "Chinabus rocks my socks bro.",
    date: "1/5/2030",
    rating: 4,
    like: 3
  })

bolt_bus_review = Review.create({
  post: "I love Bolt Bussssss!!! But the guy next to me was so weird lolz. ",
  date: "1/5/2010",
  rating: 4,
  like: 6,
  })

greyhound_review = Review.create({
  post: "I met my wife on Greyhound, ps she's super hawt",
  date: "1/19/2020",
  rating: 5,
  like: 4
  })

peter_pan_review = Review.create({
  post: "I lost my v-card to Pieter Pan, don't tell my boyfriend Hansel",
  date: "5/5/3020",
  rating: 3,
  like: 96
  })

#Connect review to bus company -----------------------------------

mega_bus.reviews << mega_bus_review
china_bus.reviews << china_bus_review
bolt_bus.reviews << bolt_bus_review
greyhound.reviews << greyhound_review
peter_pan.reviews << peter_pan_review

#Create Schedules

mega_bus_schedules = Schedule.create({
  departure_date: "5/5/1994",
  departure_time: "3:52 am",
  departure_location: "NYC",
  arrival_date: "5/5/2014",
  arrival_time: "3:53 pm",
  arrival_location: "Boston",
  duration: "too long"
  })

china_bus_schedules = Schedule.create({
  departure_date: "5/5/1994",
  departure_time: "3:52 am",
  departure_location: "NYC",
  arrival_date: "5/5/2014",
  arrival_time: "3:53 pm",
  arrival_location: "Trenton",
  duration: "too long"
  })

bolt_bus_schedules = Schedule.create({
  departure_date: "5/5/1994",
  departure_time: "3:52 am",
  departure_location: "NYC",
  arrival_date: "5/5/2014",
  arrival_time: "3:53 pm",
  arrival_location: "DC",
  duration: "too long"
  })

greyhound_schedules = Schedule.create({
  departure_date: "5/5/1994",
  departure_time: "3:52 am",
  departure_location: "DC",
  arrival_date: "5/5/2014",
  arrival_time: "3:53 pm",
  arrival_location: "NYC",
  duration: "too long"
  })

peter_pan_schedules = Schedule.create({
  departure_date: "5/5/1994",
  departure_time: "3:52 am",
  departure_location: "DC",
  arrival_date: "5/5/2014",
  arrival_time: "3:53 pm",
  arrival_location: "Trenton",
  duration: "too long"
  })

# Connect schedules to Companies --------------------

mega_bus.schedules << mega_bus_schedules
china_bus.schedules << china_bus_schedules
bolt_bus.schedules << bolt_bus_schedules
greyhound.schedules << greyhound_schedules
peter_pan.schedules << peter_pan_schedules
