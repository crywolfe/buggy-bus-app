class Company < ActiveRecord::Base
  has_many :reviews
  has_many :schedules
end
