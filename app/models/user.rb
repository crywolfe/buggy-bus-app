class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :name, presence: true
  validates :email, uniqueness: {case_sensitive: false}
end
