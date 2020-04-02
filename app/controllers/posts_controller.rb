class PostsController < ApplicationController

  POSTS_PER_PAGE = 10

  before_action :set_page, :set_total, :set_total_pages, only: [:index]
 
  def index
    @posts = Post.where(:status => Post::STATUS_PUBLISHED).order(:sticky, date: :desc).limit(POSTS_PER_PAGE).offset(@page * POSTS_PER_PAGE)
  end

  def show
    @post = Post.find_by slug: params[:slug]
  end

  def tags

  end
  
  private
    def set_page
      @page = params[:page].to_i || 0
    end

    def set_total
      @total = Post.where(:status => Post::STATUS_PUBLISHED).size
    end

    def set_total_pages
      if @total <= POSTS_PER_PAGE
        @paginated = false
      else
        @paginated = (@total.to_f / POSTS_PER_PAGE.to_f).ceil 
      end
    end

end