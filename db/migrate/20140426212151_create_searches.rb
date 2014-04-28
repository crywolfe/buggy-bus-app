class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :departure_date
      t.string :departure_time
      t.string :departure_location
      t.string :arrival_date
      t.string :arrival_time
      t.string :arrival_location
      t.string :departure_location
      t.string :duration
      t.references :user
      t.timestamps
    end
  end
end
