class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_active_item

  protected

  def set_active_item; end

  def require_admin
    redirect_to(root_path) unless current_user.admin?
  end

  private

  def possible_actores
    Actor.sorted.map { |a| [a.nombre, a.id]}
  end
  helper_method :possible_actores
end
