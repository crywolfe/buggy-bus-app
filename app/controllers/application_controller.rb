class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def parse_date(params)
    year = params["departure_date(1i)"]
    month = params["departure_date(2i)"]
    day = params["departure_date(3i)"]
    return "#{year}/#{month}/#{day}"
  end
end
