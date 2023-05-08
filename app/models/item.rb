class Item < ApplicationRecord
  belongs_to :category

  validates :name, :description, :weight, :width, :height, :length, presence: true
end
