class Product < ApplicationRecord

  enum status: [:draft, :live, :archived]
  enum product_type: [:print, :class]

  after_validation :set_slug, only: [:create, :update]

  validates :title, presence: true, length: { minimum: 1, maximum: 120 }, uniqueness: { message: "The title must be unique" }
  validates :description, presence: true, length: { minimum: 1 }
  validates :date, presence: true
  validates :status, presence: true
  validates :product_type, presence: true
  validates :price, presence: true, numericality: true

  has_one_attached :mainImage

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def self.status_to_i(status)
    self.statuses[status]
  end

  def self.product_type_to_i(product_type)
    self.product_types[product_type]
  end

end
