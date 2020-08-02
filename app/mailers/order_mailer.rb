class OrderMailer < ApplicationMailer
  default from: 'notifications@journalofcuriousthings.co.uk'
 
  def order_confirmation
    @order = params[:order]
    @product = Product.find(@order.product_id)
    mail(to: @order.email, from: 'Journal of curious things', subject: "Order confirmation #{@order.charge_id} of #{@product.title}")
  end
end
