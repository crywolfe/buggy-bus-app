class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :departure_date
      t.string :departure_time
      t.string :departure_location
      t.string :arrival_date
      t.string :arrival_time
      t.string :arrival_location
      t.string :departure_location
      t.string :duration
      t.string :price
      t.references :company
      t.timestamps
    end
  end
end
