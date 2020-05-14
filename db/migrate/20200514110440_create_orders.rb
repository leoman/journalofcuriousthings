class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.string :name
      t.string :email
      t.integer :status, default: 0
      t.string :token
      t.string :charge_id
      t.string :error_message
      t.integer :payment_gateway
      t.timestamps
    end

    add_monetize :orders, :price
    add_foreign_key :orders, :products
  end
end