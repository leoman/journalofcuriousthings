class OrdersController < ApplicationController
 
  before_action :prepare_new_order, only: [:paypal_create_payment]

  SUCCESS_MESSAGE = 'Order Performed Successfully!'
  FAILURE_MESSAGE = 'Oops something went wrong. Please call the administrator'

  def initialize
    super
    @@page_title = "Orders Title"
    @@navigation_page = :products_path
  end

  def details
    @product = Product.find_by slug: params[:slug], status: Product.statuses[:live]
    if @product
      @order = Order.new
      @order.product_id = @product.id
      @order.set_paypal_payment_gateway
    else
      @message = FAILURE_MESSAGE
    end
  end
  
  def create
    @order = Order.new(order_params)
    @product = Product.find(@order.product_id)

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_checkout_path(@order), notice: 'Order was successfully created.' }
      else
        format.html { render :details }
      end
    end
  end

  def checkout
    @order = Order.recently_created.find_by! id: params[:order_id]
    @product = Product.find(@order.product_id)
  end

  def submit
    @order = nil
    @order = Orders::Paypal.finish(order_params[:charge_id])
    @product = Product.find(@order.product_id)
  ensure
    if @order&.save
      OrderMailer.with(order: @order).order_confirmation.deliver_later
    else 
      @error = FAILURE_MESSAGE
    end
  end

  def paypal_create_payment
    # byebug
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
    @order = Order.recently_created.find_by(id: order_params[:id])
    # @order = Order.new(order_params)
    # @order.user_id = current_user.id
    @product = Product.find(@order.product_id)
    @order.price_cents = @product.price_cents
  end

  def order_params
    # byebug
    params.require(:order).permit(:id, :name, :email, :product_id, :token, :payment_gateway, :charge_id)
  end
  
end