class SearchesController < ApplicationController

  def index
    @searches = Search.all
    @schedules = Schedule.all
    # @searches = Search.find_by({id: params[:id]})
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
    departure_date = parse_date(search_params)
    departure_location = search_params['departure_location']
    arrival_location = search_params['arrival_location']
    @search = Search.create({
      departure_location: departure_location,
      arrival_location: arrival_location,
      departure_date: departure_date
      })
    query_string = "departure_location LIKE ? AND arrival_location LIKE ? AND departure_date LIKE ?"
    @search_results = Schedule.where(
      query_string,
      '%' + departure_location + '%',
      '%' + arrival_location + '%',
      '%' + departure_date + '%'
      )
    
    # respond_to do |format|
    #   format.html

      # format.json do
        render json: @search_results
    #   end
    # end

  end

  private

    def search_params
      binding.pry
      params.require(:search).permit("departure_location", "arrival_location", "departure_date")
    end

end
