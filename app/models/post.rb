class Post < ApplicationRecord

  after_validation :set_slug, only: [:create, :update]

  enum status: [:published, :unpublished]

  validates :title, presence: true, length: { minimum: 1, maximum: 120 }, uniqueness: { message: "The title must be unique" }
  validates :content, presence: true, length: { minimum: 1 }
  validates :date, presence: true
  validates :status, presence: true

  STATUS_PUBLISHED = Post.statuses.first.first

  has_one_attached :mainImage

  def self.status_to_i(status)
    Post.statuses[status]
  end

  def set_slug
    self.slug = title.to_s.parameterize
  end
end
