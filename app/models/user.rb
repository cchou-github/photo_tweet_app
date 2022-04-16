class User < ApplicationRecord
  before_create :generate_random_id
  has_many :photos
  #TODO: password complexity

  has_secure_password
  validates_uniqueness_of :account
end
