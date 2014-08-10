class ActoresController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:edit, :update]
  before_action :find_actor, only: [:show, :edit, :update]

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
    if @actor.update(actor_params)
      @actor.create_activity :update, owner: current_user, params: actor_params
      redirect_to actores_path, notice: "#{@actor} actualizado"
    else
      render :edit
    end
  end

  private

  def find_actor
    @actor = Actor.find params[:id]
  end

  def actor_params
    params.require(:actor).permit :logo, :logo_cache, :remove_logo, :nombre, :acronimo
  end

  def grupo_preguntas
    @grupo_preguntas ||= if params[:preguntas].present?
      GrupoPreguntas.find(params[:preguntas])
    else
      GrupoPreguntas.first
    end
  end
  helper_method :grupo_preguntas

  def set_active_item
    @active_item = :actores
  end
end
