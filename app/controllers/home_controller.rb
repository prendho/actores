class HomeController < ApplicationController
  def index
    redirect_to actores_path if current_user && current_user.admin
  end
end
