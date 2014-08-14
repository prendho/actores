class ActoresController < ApplicationController
  include Answerable

  before_action :require_login
  before_action :require_admin, only: [:edit, :update]

  def index
    @actores = if params[:search].present?
      Actor.like(params[:search]).sorted
    else
      Actor.sorted
    end
  end

  def show
  end

  def edit
  end

  def update
    if actor.update(actor_params)
      actor.create_activity :update, owner: current_user, params: actor_params
      redirect_to actores_path, notice: "#{actor} actualizado"
    else
      render :edit
    end
  end

  protected

  def actor
    @actor ||= Actor.find params[:id]
  end
  helper_method :actor
  alias_method :resource, :actor
  helper_method :resource

  private

  def actor_params
    params.require(:actor).permit :logo, :logo_cache, :remove_logo, :nombre, :acronimo
  end

  def set_active_item
    @active_item = :actores
  end

  def grupo_preguntas_kind
    :actor
  end
end
