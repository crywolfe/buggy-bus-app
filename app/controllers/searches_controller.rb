class SearchesController < ApplicationController

  def index
    @searches = Search.all
    @schedules = Schedule.all
  end

  def show
    search = Search.find(params["id"])
     @schedules = Schedule.where(
      departure_location: "#{search.departure_location}",
      arrival_location: "#{search.arrival_location}",
       departure_date: "#{search.departure_date}"
       )

    # respond_to do |format|
    #   format.json { render json: @schedules}
    # end
    # binding.pry
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to("/searches/#{@search.id}")
    else
      render :new
    end
  end

  private

  def search_params
    binding.pry
    params.require(:search).permit(
    :departure_location,
    :arrival_location,
    :departure_date
    )
  end

end
