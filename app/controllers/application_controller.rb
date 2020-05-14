class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper_method :format_price

  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  def format_price(price_cents)
    Money.new(price_cents, :gbp)
  end

  private

    def page_not_found
      render "errors/not_found", status: :not_found
    end
end
