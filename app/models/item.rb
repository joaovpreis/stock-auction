class Item < ApplicationRecord
  has_one_attached :photo
  belongs_to :category

  validates :name, :description, :weight, :width, :height, :length, presence: true
  validate :photo_attached

  before_validation :generate_code

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def photo_attached
      errors.add(:photo, 'must be attached') unless self.photo.attached?
  end
end