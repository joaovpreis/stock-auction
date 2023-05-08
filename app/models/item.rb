class Item < ApplicationRecord
  belongs_to :category

  validates :name, :description, :weight, :width, :height, :length, presence: true

  before_validation :generate_code

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
