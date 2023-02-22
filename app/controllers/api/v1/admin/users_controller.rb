class Api::V1::Admin::UsersController < ApplicationController
  before_action :only_admin
  def index
    @users = User.all.update_order
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      head :created
    else
      head :bad_request
    end
  end

  def show
    set_user
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.update!(name:params[:user][:name],email:params[:user][:email],password:params[:user][:password])
      head :ok
    else
      head :bad_request
    end

  end

  def destroy
    set_user
    if @user.destroy!
      head :ok
    else
      head :bad_request
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest, :admin)
  end

  def only_admin
    if current_api_v1_user.admin == false
      head :unauthorized
    end
  end
end
