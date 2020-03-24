class Post < ApplicationRecord
    enum status: [:published, :unpublished]

    validates :title, presence: true, length: { minimum: 1, maximum: 120 }, uniqueness: { message: "The title must be unique" }
    validates :content, presence: true, length: { minimum: 1 }
    validates :date, presence: true
    validates :status, presence: true

    STATUS_PUBLISHED = Post.statuses.first.first

    def self.status_to_i(status)
        Post.statuses[status]
    end
end
