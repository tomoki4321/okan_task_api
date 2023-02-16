class Api::V1::TasksController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_api_v1_user.id).includes(:user).recent_order
  end

  def new
    @task=Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save!
      head :created
    end
  end

  def edit
    set_task
  end

  def show
    set_task
  end

  def update
    set_task
    if @task.update!(name:params[:task][:name],content:params[:task][:content],limit:params[:task][:limit],priority:params[:task][:priority],status:params[:task][:status],progress:params[:task][:progress])
      head :created
    end
  end
  
  def destroy
    set_task
    @task.destroy!
    head :ok
  end

  private

  def set_task
    @task=Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id,:name, :content, :priority, :status, :progress,:limit).merge(user_id: current_api_v1_user.id)
  end

end
