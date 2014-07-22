class ActoresController < ApplicationController
  before_action :require_login

  def index
    @actores = Actor.sorted
  end

  def show
    @actor = Actor.find params[:id]
  end

  private

  def set_active_item
    @active_item = :actores
  end
end
