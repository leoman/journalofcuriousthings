class Admin::OrdersController < Admin::BaseController
  @@title = "Orders"

  before_action :set_page, :set_total, :set_total_pages, only: [:index]

  def index
    @orders = Order.order(date: :desc).limit(@@posts_per_page).offset(@page * @@posts_per_page)
  end

  private

    def set_title
      @title = @@title
    end

    def set_page
      @page = params[:page].to_i || 0
    end

    def set_total
      @total = Order.all.size
    end

    def set_total_pages
      if @total <= @@posts_per_page
        @paginated = false
      else
        @paginated = (@total.to_f / @@posts_per_page.to_f).ceil 
      end
    end

end