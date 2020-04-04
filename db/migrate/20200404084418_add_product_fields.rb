class AddProductFields < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :status, :integer
    add_column :products, :type, :integer
  end
end
