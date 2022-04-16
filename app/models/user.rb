class User < ApplicationRecord
  self.implicit_order_column = "created_at"
  has_many :photos
  #TODO: password complexity

  has_secure_password
  validates_uniqueness_of :account
end
