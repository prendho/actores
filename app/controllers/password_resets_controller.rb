# encoding: utf-8
class PasswordResetsController < ApplicationController
  before_action :redirect_if_logged_in

  def create
    @user = User.find_by email: params[:email]
    @user.async_deliver_reset_password_instructions! if @user
    redirect_to root_path, notice: "Te hemos enviado instrucciones por correo electrónico"
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_path, notice: "La contraseña fue actualizada. Por favor inicia sesión con tu nueva contraseña"
    else
      render action: "edit"
    end
  end
end
