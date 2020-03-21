class Admin::PostsController < ApplicationController
  TITLE = "Posts"

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:index, :show, :new, :edit]

  def index
      @posts = Post.all
  end

  def show
  end

  def new
      @post = Post.new
  end

  def edit
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

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
          @post = Post.find(params[:id])
      end

      def set_title
        @title = Admin::PostsController::TITLE
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
          postParams = params.require(:post).permit(:title, :content, :date)
          postParams[:status] = params[:post][:status].to_i
          postParams
      end
end
