class Theme < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 120 }, uniqueness: { message: "The name must be unique" }
  has_many :product_themes
  has_many :products, through: :product_themes
end
