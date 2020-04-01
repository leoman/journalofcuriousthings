class AddJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :post, foreign_key: true
      t.timestamps
    end
  end
end
