class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @today = Category.find_by(date: Date.today)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private
  def set_article
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :date, :status)
  end
end
