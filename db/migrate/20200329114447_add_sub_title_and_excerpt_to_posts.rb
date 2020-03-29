class AddSubTitleAndExcerptToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :subtitle, :string
    add_column :posts, :excerpt, :string
  end
end
