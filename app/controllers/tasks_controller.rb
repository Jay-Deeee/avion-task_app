class TasksController < ApplicationController
  before_action :set_category
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @category.tasks
    @today = Task.find_by(date: Date.today)
  end

  def show; end

  def create
    @task = @category.tasks.new(task_params.except(:due_hour, :due_minute, :due_meridian))
    @task.due_date = build_due_date_from_params

    if @task.save
      redirect_to category_path(@category), notice: "Task saved successfully."
    else
      flash.now[:alert] = "Failed to save task."
      render "categories/show", status: :unprocessable_entity
    end
  end

  def edit; end
  
  def update
    @task.due_date = build_due_date_from_params

    if @task.update(task_params.except(:due_hour, :due_minute, :due_meridian))
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

  def build_due_date_from_params
    hour = params[:task][:due_hour].to_i
    hour += 12 if params[:task][:due_meridian] == "PM" && hour != 12
    hour = 0 if params[:task][:due_meridian] == "AM" && hour == 12
  
    due_date = Time.zone.local(
      params[:task]["due_date(1i)"].to_i,
      params[:task]["due_date(2i)"].to_i,
      params[:task]["due_date(3i)"].to_i,
      hour,
      params[:task][:due_minute].to_i
    )

    params[:task][:due_date] = due_date
  end
end
