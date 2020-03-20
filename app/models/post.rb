class Post < ApplicationRecord
    enum status: [:published, :unpublished]
end
