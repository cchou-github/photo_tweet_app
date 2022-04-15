class User < ApplicationRecord
  before_create :generate_random_id
  #TODO: password complexity

  has_secure_password    
  validates_uniqueness_of :account

  def generate_random_id
    self.id = SecureRandom.uuid
  end 
end
