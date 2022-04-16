class Picture < ApplicationRecord
  belongs_to :user
  has_one_attached :image_file

  validates :title, presence: true
  validate :image_file_attached?

  private
  def image_file_attached?
    errors.add(:image_file, :blank) unless image_file.attached?
  end
end
