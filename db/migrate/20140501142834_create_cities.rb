class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :boston
      t.string :new_york
      t.string :philadelphia
      t.string :baltimore
      t.string :washington
      t.string :richmond
      t.string :hampton
    end
  end
end
