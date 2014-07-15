# encoding: utf-8
class SessionsController < ApplicationController
  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      respond_to do |format|
        format.html {
          redirect_back_or_to root_path, notice: "Hola, #{@user}"
        }
        format.js {
          render text: "window.location.href='/';"
        }
      end
    else
      respond_to do |format|
        format.html {
          redirect_to root_path, notice: "E-mail o contraseña inválidos"
        }
        format.js {
          render text: "alertify.log('E-mail o contraseña inválidos');"
        }
      end
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Cerraste sesión"
  end
end
