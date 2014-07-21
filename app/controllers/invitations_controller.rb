# encoding: utf-8
class InvitationsController < ApplicationController
  before_action :is_logged_in?
  before_action :find_user
  before_action :expired?

  def show
  end

  def update
    @user.require_password = true # force the user to enter password
    if @user.update(user_params)
      @user.was_invited!
      login(user_params[:email], user_params[:password])
      redirect_to root_path, notice: "Tu cuenta ha sido activada"
    else
      render :show
    end
  end

  private

  def expired?
    unless @user.valid_invitation?
      @user.update!(will_invite: true)
      render :expired and return false
    end
  end

  def find_user
    @user = User.find_by! invitation_token: params[:id]
  end

  def user_params
    params.require(:user).permit(:nombres, :email, :actor_id, :password, :password_confirmation)
  end

  def is_logged_in?
    redirect_to root_path, notice: "Ya has iniciado sesión" if current_user
  end
end
