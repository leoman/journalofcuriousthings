class AddProductsDateField < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :date, :datetime
  end
end
