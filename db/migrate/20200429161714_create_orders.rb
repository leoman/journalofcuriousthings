class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :status
      t.string :token
      t.string :charge_id
      t.string :error_message
      t.integer :payment_gateway
      t.datetime :date
      t.timestamps
    end

    add_foreign_key :orders, :products
  end
end
