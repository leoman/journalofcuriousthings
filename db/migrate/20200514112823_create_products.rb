class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :slug
      t.string :subtitle
      t.string :description
      t.integer :status, default: 0
      t.integer :product_type, default: 0
      t.datetime :date
      t.timestamps
    end

    add_monetize :products, :price
  end
end
