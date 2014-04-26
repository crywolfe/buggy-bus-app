class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :post
      t.string :date
      t.integer :rating
      t.integer :like
      t.timestamps
    end
  end
end
