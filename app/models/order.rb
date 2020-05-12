class Order < ApplicationRecord
  enum status: { pending: 0, failed: 1, paid: 2, paypal_executed: 3}
  enum payment_gateway: { paypal: 0 }
  belongs_to :product

  scope :recently_created, ->  { where(created_at: 10.minutes.ago..DateTime.now) }

  validates :name, presence: true, length: { minimum: 1, maximum: 120 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  def set_paypal_payment_gateway
    self.payment_gateway = Order.payment_gateways[:paypal]
  end

  def set_paid
    self.status = Order.statuses[:paid]
  end

  def set_failed
    self.status = Order.statuses[:failed]
  end
  
  def set_paypal_executed
    self.status = Order.statuses[:paypal_executed]
  end
end