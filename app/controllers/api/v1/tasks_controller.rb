class Api::V1::TasksController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_api_v1_user).includes(:user)
  end


  private
  def task_params
    params.require(:task).permit(:user_id, :name, :content, :priority, :status, :progress).merge(user: current_api_v1_user)
  end
end
