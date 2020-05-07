class OrdersController < ApplicationController
 
  before_action :prepare_new_order, only: [:paypal_create_payment]

  SUCCESS_MESSAGE = 'Order Performed Successfully!'
  FAILURE_MESSAGE = 'Oops something went wrong. Please call the administrator'

  def details
    @product = Product.find_by slug: params[:slug], status: Product.statuses[:live]
    if @product
      
    else
      render html: FAILURE_MESSAGE
    end
  end

  def submit
    @order = nil
    @order = Orders::Paypal.finish(order_params[:charge_id])
  ensure
    if @order&.save
      if @order.paid?
        # Success is rendere when order is paid and saved
        return render html: SUCCESS_MESSAGE
      elsif @order.failed? && !@order.error_message.blank?
        # Render error only if order failed and there is an error_message
        return render html: @order.error_message
      end
    end
    render html: FAILURE_MESSAGE
  end

  def paypal_create_payment
    result = Orders::Paypal.create_payment(order: @order, product: @product)
    if result
      render json: { token: result }, status: :ok
    else
      render json: {error: FAILURE_MESSAGE}, status: :unprocessable_entity
    end
  end

  def paypal_execute_payment
    if Orders::Paypal.execute_payment(payment_id: params[:paymentID], payer_id: params[:payerID])
      render json: {}, status: :ok
    else
      render json: {error: FAILURE_MESSAGE}, status: :unprocessable_entity
    end
  end

  private
  # Initialize a new order and and set its user, product and price.
  def prepare_new_order
    @order = Order.new(order_params)
    # @order.user_id = current_user.id
    @product = Product.find(@order.product_id)
    @order.price_cents = @product.price
  end

  def order_params
    params.require(:orders).permit(:product_id, :token, :payment_gateway, :charge_id)
  end
  
end