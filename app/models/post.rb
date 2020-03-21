class Post < ApplicationRecord
    enum status: [:published, :unpublished]

    def self.status_to_i(status)
        Post.statuses[status]
    end
end
