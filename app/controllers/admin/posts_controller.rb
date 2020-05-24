class Admin::PostsController < Admin::BaseController
  @@title = "Posts"

  before_action :set_post, only: [:show, :edit, :update, :destroy, :preview]
  before_action :set_page, :set_total, :set_total_pages, only: [:index]

  def initialize
    super
    @@navigation_page = :admin_posts_path
  end

  def index
    @posts = Post.order(sticky: :desc, date: :desc).limit(@@posts_per_page).offset(@page * @@posts_per_page)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    @preview = true
    @return = admin_posts_path({ page: @page })
    render layout: "application", template: 'posts/show'
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def set_title
      @title = @@title
    end

    def split_post_tags(tags)
      tags.split(',')
    end

    def post_params 
      postParams = params.require(:post).permit(:title, :content, :date, :sticky, :subtitle, :excerpt, :mainImage, :tag_list, :tag)
      postParams[:tag_ids] = split_post_tags(params[:post][:tag_ids])
      postParams[:status] = params[:post][:status].to_i
      postParams
    end

    def set_page
      @page = params[:page].to_i || 0
    end

    def set_total
      @total = Post.all.size
    end

    def set_total_pages
      if @total <= @@posts_per_page
        @paginated = false
      else
        @paginated = (@total.to_f / @@posts_per_page.to_f).ceil 
      end
    end

end
