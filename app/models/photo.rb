class Photo < ApplicationRecord
  self.implicit_order_column = "created_at"
  before_create :generate_random_id
  belongs_to :user
  has_one_attached :image_file #TODO: Validate content type
  
  validates :title, presence: true
  validate :image_file_attached?

  private
  def image_file_attached?
    errors.add(:image_file, :blank) unless image_file.attached?
  end
end
