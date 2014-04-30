class SearchesController < ApplicationController

  def index
    # @schedules = Search.all
  end
# User.where("name = :name and email = :email", { name: "Joe", email: "joe@example.com" })
# @schedules = Schedule.where("departure_location = :departure_location and arrival_location = :arrival_location", { departure_location: "#{search.departure_location}", arrival_location: "search.arrival_location" })
#   def show
#      search = Search.find(params["id"])
#      @schedules = Schedule.where("departure_location = :departure_location and arrival_location = :arrival_location", { departure_location: "#{search.departure_location}", arrival_location: "search.arrival_location" })
# binding.pry
#     # @schedules = Schedule.where([
#     #   departure_location: search.departure_location,
#     #   arrival_location: search.arrival_location,
#     #   departure_date: search.departure_date])

#     # @search = Search.find_by(id: params[:id])
#     # @searches = Search.all
#     # # binding.pry
#     # @schedules = Search.all
#       end


#    # def get_schedules
#    #    Schedule.where departure_time: "NYC", arrival_location: "Boston", departure_date: "5/5/1994" do |schedule|
#    #    puts schedule
#    # end


#   def search
#   end


end



