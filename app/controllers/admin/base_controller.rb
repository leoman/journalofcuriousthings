class Admin::BaseController < ApplicationController
  before_action :require_login, :set_title
  layout "admin"
  
  @@posts_per_page = 10
  @@page_title = "Admin :: Journal of Curious Things"
  @@navigation_page = ""


  def show
  end

  def edit
  end

  private
    def set_page_title
      @page_title = @@page_title
    end

    def set_navigation_page
      if @@navigation_page && @@navigation_page != ""
        @navigation_page = send(@@navigation_page)
      end
    end

end