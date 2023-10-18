class JobsController < ApplicationController
    before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end

#   def create
#     @job = Job.new(job_params)
#     if @job.save
#       redirect_to jobs_path
#     else
#       render :new, status: :unprocessable_entity
#     end
#   end
  def create

  @job = Job.new(job_params)
  if @job.save
    @job.broadcast_append_to("jobs") # Tạo Turbo Stream để cập nhật danh sách công việc
    redirect_to jobs_path
  else
    render :new, status: :unprocessable_entity
  end
  end
  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  private

  def set_job
    @job = Job.find_by(id: params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
