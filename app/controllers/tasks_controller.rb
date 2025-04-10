class TasksController < ApplicationController
  before_action :set_category
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @category.tasks
    @today = Task.find_by(date: Date.today)
  end

  def show; end

  def create
    @task = @category.tasks.create(task_params)

    if @task.persisted?
      redirect_to category_path(@category), notice: "Task saved successfully."
    else
      flash.now[:alert] = "Failed to save task."
      render "categories/show", status: :unprocessable_entity
    end
  end

  def edit; end
  
  def update
    if @task.update(task_params)
      redirect_to @category, notice: "Task has been updated."
    else
      flash[:alert] = "Failed to update task."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    redirect_to @category, status: :see_other, notice: "Task has been deleted."
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :body, :date, :due_date, :status, :priority, :category_id)
  end
end
