class ActivityController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @activities = PublicActivity::Activity.order(id: :desc).page(params[:page]).includes(:owner, :trackable)
  end

  private

  def set_active_item
    @active_item = :actividad
  end
end
