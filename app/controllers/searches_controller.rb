class SearchesController < ApplicationController

  def index
  end

  def show
    @search = Search.find_by(id: params[:id])
    @searches = Search.all
    binding.pry
    @schedules = Schedule.where departure_location: "NYC" do |schedule|
      schedule.each do |details|
        details.duration
      end
    end
  end

   # def get_schedules
   #    Schedule.where departure_time: "NYC", arrival_location: "Boston", departure_date: "5/5/1994" do |schedule|
   #    puts schedule
   # end


  def search
  end


end



