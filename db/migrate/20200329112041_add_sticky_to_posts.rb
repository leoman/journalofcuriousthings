class AddStickyToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :sticky, :boolean
  end
end
