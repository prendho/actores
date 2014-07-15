class HomeController < ApplicationController
  def index
    redirect_to users_path if current_user && current_user.admin
  end
end
