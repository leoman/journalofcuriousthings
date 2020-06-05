class AddContentRawToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :content_raw, :string
  end
end
