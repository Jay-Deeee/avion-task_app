class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @categories = Category.includes(:tasks)
    @today = Date.today
    @high_prio_tasks = Task.where(priority: "high").order(:due_date)
  end

  def show
    @new_task = @category.tasks.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: "Category: '#{@category.name}' saved successfully."
    else
      flash[:alert] = "Failed to save category."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category has been updated."
    else
      flash[:alert] = "Failed to update category."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, status: :see_other, notice: "Category has been deleted."
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :user_id)
  end

  # def record_not_found
  #   redirect_to articles_path, alert: "Record does not exist."
  # end

  # def invalid_foreign_key
  #   redirect_to articles_path, alert: "Unable to delete category. Still referenced from tasks."
  # end
end
