class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @categories = current_user.categories.includes(:tasks)
    @today = Date.today
    @high_prio_tasks = current_user.tasks.where(priority: "high").order(:due_date)
    @med_prio_tasks = current_user.tasks.where(priority: "medium").order(:due_date)
    @low_prio_tasks = current_user.tasks.where(priority: "low").order(:due_date)
  end

  def show
    @task = @category.tasks.new
    @today_tasks = @category.tasks.where(due_date: Time.now.beginning_of_day..Time.now.end_of_day)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)

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
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def record_not_found
    redirect_to categories_path, alert: "Record does not exist."
  end

  def invalid_foreign_key
    redirect_to categories_path, alert: "Unable to delete category. Still referenced from tasks."
  end
end
