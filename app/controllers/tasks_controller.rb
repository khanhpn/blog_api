class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @task = Task.new
  end

  def new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def task_params
    params.require(:task).permit(:description)
  end
end
