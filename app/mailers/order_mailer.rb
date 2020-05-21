class OrderMailer < ApplicationMailer
  default from: 'notifications@journalofcuriousthings.co.uk'
 
  def order_confirmation
    @order = params[:order]
    @product = Product.find(@order.product_id)
    mail(to: @order.email, subject: "Order confirmation #{@order.id} of #{@product.title}")
  end
end
