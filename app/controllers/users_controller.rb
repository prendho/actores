class UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @users = User.all.includes(:actor)
  end

  def new
    @user = User.new(will_invite: true)
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to action: :index
  end

  private

  def require_admin
    redirect_to(root_path) unless current_user.admin?
  end

  def set_active_item
    @active_item = :usuarios
  end

  def user_params
    params.require(:user).permit(:nombres, :email, :password, :actor_id, :will_invite, :admin)
  end
end
