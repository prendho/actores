class UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: :show

  def index
    @users = User.all.includes(:actor)
  end

  def show
    @user = User.find params[:id]
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
      @user.create_activity :create, owner: current_user, params: user_params
      redirect_to action: :index
    else
      render :new
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      @user.create_activity :update, owner: current_user, params: user_params
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.create_activity :destroy, owner: current_user, params: @user.attributes.slice("nombres", "email")
    @user.destroy
    redirect_to action: :index
  end

  private

  def set_active_item
    @active_item = :usuarios
  end

  def user_params
    params.require(:user).permit(:nombres, :email, :password, :password_confirmation, :actor_id, :will_invite, :admin)
  end
end
