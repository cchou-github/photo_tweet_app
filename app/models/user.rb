class User < ApplicationRecord
  # remove the comment if you want to insert the in chronological order
  # self.implicit_order_column = "created_at" 

  PASSWORD_REQUIREMENTS= /\A
    (?=.{8,}) # at leaset 8 characters long
  /x

  has_many :photos
  validates :account, presence: true
  validates :password, presence: true, format: PASSWORD_REQUIREMENTS

  has_secure_password
  validates_uniqueness_of :account
end
