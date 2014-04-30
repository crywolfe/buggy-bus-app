class Schedule < ActiveRecord::Base
  belongs_to :company
   def get_schedules
    Schedule.find_by departure_location: 'NYC'
  end
end
