class AddPostsTagsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tags do |t|
      t.belongs_to :posts
      t.belongs_to :tags
      t.timestamps
    end
  end
end
