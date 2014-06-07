class SearchesController < ApplicationController

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
    render(:index)
  end

  def create

    departure_date = params['search']['departure_date']
    departure_location = search_params['departure_location']
    arrival_location = search_params['arrival_location']

    @search_results = Search.collect(departure_date, departure_location, arrival_location)

    render json: @search_results
  end

  private

    def search_params
      params.require(:search).permit("departure_location", "arrival_location", "departure_date")
    end

end
