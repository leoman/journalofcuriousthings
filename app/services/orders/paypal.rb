class Orders::Paypal < ApplicationController

  COMPLETED_STATUS = "COMPLETED"

  # def self.create_payment(order:, product:)
  #   payment_price = (product.price_cents/100.0).to_s
  #   currency = "GBP"
  #   payment = PayPal::SDK::REST::Payment.new({
  #     intent:  "sale",
  #     payer:  { payment_method: "paypal" },
  #     redirect_urls: {
  #       return_url: "/",
  #       cancel_url: "/" 
  #     },
  #     transactions:  [{
  #       item_list: {
  #         items: [{
  #           name: product.title,
  #           sku: product.title,
  #           price: payment_price,
  #           currency: currency,
  #           quantity: 1
  #         }]
  #       },
  #       amount: {
  #         total: payment_price,
  #         currency: currency
  #       },
  #       description:  "Payment for: #{product.title}"
  #     }]
  #   })
  #   if payment.create
  #     order.token = payment.token
  #     order.charge_id = payment.id
  #     return payment.token if order.save
  #   end
  # end

  def self.execute_payment(order_id:, status:, charge_id:)
    order = Order.recently_created.find_by! id: order_id
    return false unless order
    if order && status == COMPLETED_STATUS
      order.set_paypal_executed
      order.charge_id = charge_id
      return order.save
    else
      order.set_failed
      order.save
      return false
    end
  end

  def self.finish(charge_id)
    order = Order.paypal_executed.recently_created.find_by(charge_id: charge_id)
    return nil if order.nil?
    order.set_paid
    order
  end

end