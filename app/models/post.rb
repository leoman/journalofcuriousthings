class Post < ApplicationRecord

  after_validation :set_slug, only: [:create, :update]

  enum status: [:published, :unpublished]

  validates :title, presence: true, length: { minimum: 1, maximum: 120 }, uniqueness: { message: "The title must be unique" }
  validates :content, presence: true, length: { minimum: 1 }
  validates :date, presence: true
  validates :status, presence: true

  STATUS_PUBLISHED = Post.statuses.first.first

  has_one_attached :mainImage
  has_many :taggings
  has_many :tags, through: :taggings

  def self.status_to_i(status)
    Post.statuses[status]
  end

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

end
