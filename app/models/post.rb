class Post < ApplicationRecord
    enum status: [:published, :unpublished]

    STATUS_PUBLISHED = Post.statuses.first.first

    def self.status_to_i(status)
        Post.statuses[status]
    end
end
