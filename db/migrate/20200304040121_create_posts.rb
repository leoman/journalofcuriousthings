class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.datetime :date
      t.integer :status

      t.timestamps
    end
    add_index :posts, :title
  end
end
