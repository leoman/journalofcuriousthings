# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  def order_confirmation
    order = Order.new(id: 1, name: "Joe Smith", email: "joe@gmail.com", product_id: 1)
    OrderMailer.with(order: order).order_confirmation
  end

end
