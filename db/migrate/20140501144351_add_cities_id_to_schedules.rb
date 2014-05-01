class AddCitiesIdToSchedules < ActiveRecord::Migration
  def change
    add_reference :schedules, :city, index: true
  end
end
