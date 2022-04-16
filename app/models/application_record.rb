class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def generate_random_id
    self.id = SecureRandom.uuid
  end 
end
