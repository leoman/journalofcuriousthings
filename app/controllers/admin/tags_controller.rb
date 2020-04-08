class Admin::TagsController < ApplicationController

  TITLE = "Tags"
  layout "admin"

  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action :set_title, only: [:index, :new, :edit]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_tag
          @tag = Tag.find(params[:id])
      end

      def set_title
        # @title = self::TITLE
        @title = 'Tags'
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def tag_params
          tagParams = params.require(:tag).permit(:name)
      end
end
