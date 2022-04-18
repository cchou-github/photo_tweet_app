class Photo < ApplicationRecord  
  belongs_to :user
  has_one_attached :image_file

  validate :correct_image_file_mime_type
  validates :title, presence: true, length: { maximum: 30 }
  validate :image_file_attached?

  private
  def image_file_attached?
    errors.add(:image_file, :blank) unless image_file.attached?
  end

  def correct_image_file_mime_type
    if image_file.attached? && !image_file.content_type.start_with?("image/")
      errors.add(:image_file, :wrong_mime_type)
    end
  end
end
