class Admin::ThemesController < ApplicationController

  TITLE = "Themes"
  layout "admin"

  before_action :set_theme, only: [:edit, :update, :destroy]
  before_action :set_title, only: [:index, :new, :edit]

  def index
    @themes = Theme.all
  end

  
  def show
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = Theme.new(theme_params)

    respond_to do |format|
      if @theme.save
        format.html { redirect_to admin_themes_path, notice: 'Theme was successfully created.' }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to admin_themes_path, notice: 'Theme was successfully updated.' }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to admin_themes_url, notice: 'Theme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_theme
      @theme = Theme.find(params[:id])
    end

    def set_title
      @title = Admin::ThemesController::TITLE
    end

    def theme_params
      themeParams = params.require(:theme).permit(:name)
    end
end
