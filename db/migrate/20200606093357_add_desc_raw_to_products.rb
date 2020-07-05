class AddDescRawToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :description_raw, :string
  end
end
