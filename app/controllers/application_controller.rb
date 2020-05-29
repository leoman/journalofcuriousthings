class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper_method :format_price
  before_action :set_page_title
  before_action :set_navigation_page

  @@page_title = ""
  @@navigation_page = ""

  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  def format_price(price_cents)
    Money.locale_backend = nil
    Money.new(price_cents, 'GBP').format
  end

  private

    def set_page_title
      @page_title = @@page_title
    end

    def set_navigation_page
      @navigation_page = send(@@navigation_page)
    end

    def page_not_found
      render "errors/not_found", status: :not_found
    end
end
