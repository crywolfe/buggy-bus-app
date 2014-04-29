class BuggyBusesController < ApplicationController

  def index
    @searches = Search.all
  end

  def search
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to("/searches")
    else
      render :new
    end
  end

  private

  def search_params
    # binding.pry
    params.require(:search).permit(
    :departure_location,
    :arrival_location,
    :departure_date
    )
  end

end
