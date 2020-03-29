class PostsController < ApplicationController

  POSTS_PER_PAGE = 10

  before_action :set_page, :set_total, only: [:index]
 
  def index
    @posts = Post.where(:status => Post::STATUS_PUBLISHED).order(:sticky, date: :desc).limit(POSTS_PER_PAGE).offset(@page * POSTS_PER_PAGE)
  end
  
  private
    def set_page
      @page = params[:page].to_i || 0
    end

    def set_total
      @total = Post.where(:status => Post::STATUS_PUBLISHED).size
      @total = @total -1
    end

end