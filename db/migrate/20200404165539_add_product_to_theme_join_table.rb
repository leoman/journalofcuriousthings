class AddProductToThemeJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :product_themes do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :theme, foreign_key: true
      t.timestamps
    end
  end
end
