class Tag < ApplicationRecord

  validates :name, presence: true, length: { minimum: 1, maximum: 120 }, uniqueness: { message: "The name must be unique" }

  has_many :taggings
  has_many :posts, through: :taggings
end