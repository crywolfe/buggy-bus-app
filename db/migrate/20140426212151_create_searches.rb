class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :departure_date
      t.string :departure_location
      t.string :arrival_location
      t.references :user
      t.timestamps
    end
  end
end
