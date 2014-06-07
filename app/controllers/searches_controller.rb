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

    # @search = Search.create(search_params)

    query_string = "departure_location LIKE ? AND arrival_location LIKE ? AND departure_date LIKE ?"

    @search_results = Search.collect(deparature_date, departure_location, arrival_location)

    respond_to do |format|
      format.html

      format.json {
        render json: @search_results
      }
    end

  end

  private

    def search_params
      params.require(:search).permit("departure_location", "arrival_location", "departure_date")
    end

end
