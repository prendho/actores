class MeController < ApplicationController
  before_action :require_login
  before_action :find_user

  def index
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Tu perfil fue actualizado"
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:nombres, :email, :actor_id, :password, :password_confirmation)
  end

  def find_user
    @user = current_user
  end
end
