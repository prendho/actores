class MeController < ApplicationController
  before_action :require_login
  before_action :find_user

  def index
  end

  def update
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Las contraseñas no coinciden"
      render :index and return
    end
    if @user.update(user_params)
      redirect_to action: :index
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:nombres, :email, :actor_id, :password)
  end

  def find_user
    @user = current_user
  end
end
