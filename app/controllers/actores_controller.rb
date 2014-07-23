class ActoresController < ApplicationController
  before_action :require_login

  def index
    @actores = if params[:search].present?
      Actor.like(params[:search]).sorted
    else
      Actor.sorted
    end
  end

  def show
    @actor = Actor.find params[:id]
  end

  private

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
