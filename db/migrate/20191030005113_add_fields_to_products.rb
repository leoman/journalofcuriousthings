class AddFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :title, :string
    add_column :products, :subtitle, :string
    add_column :products, :price, :float
    add_column :products, :description, :string
    add_column :products, :tester, :string
  end
end
