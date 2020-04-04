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
  has_many :product_themes
  has_many :themes, through: :product_themes

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def self.status_to_i(status)
    self.statuses[status]
  end

  def self.product_type_to_i(product_type)
    self.product_types[product_type]
  end

  def self.tagged_with(name)
    Theme.find_by!(name: name).products
  end

  def self.theme_counts
    Theme.select('themes.*, count(product_themes.theme_id) as count').joins(:product_themes).group('product_themes.theme_id')
  end

  def theme_list
    themes.map(&:name).join(', ')
  end

  def theme_list=(names)
    self.themes = names.split(',').map do |n|
      Theme.where(name: n.strip).first_or_create!
    end
  end

end
