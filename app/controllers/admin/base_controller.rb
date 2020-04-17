class Admin::BaseController < ApplicationController
  before_action :require_login, :set_title
  layout "admin"
  
  @@posts_per_page = 10

  def show
  end

  def edit
  end

end