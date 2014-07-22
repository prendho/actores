class RespuestasController < ApplicationController
  before_action :require_login
  before_action :find_actor

  def new
    @respuesta = @actor.respuestas.new
    last_grupo_preguntas!
    build_respuestas!
  end

  def create
    @respuesta = @actor.respuestas.new(respuesta_params)
    @respuesta.user = current_user
    if @respuesta.save
      next_grupo_preguntas! and build_respuestas!
    else
      last_grupo_preguntas!
    end
    render :new
  end

  def update
    @respuesta = @actor.respuestas.find(params[:respuesta][:id])
    if @respuesta.update(respuesta_params)
      next_grupo_preguntas! and build_respuestas!
    else
      last_grupo_preguntas!
    end
    render :new
  end

  private

  def build_respuestas!
    @respuesta.build_for_grupo_preguntas!(@grupo_preguntas)
  end

  def last_grupo_preguntas!
    @grupo_preguntas = if params[:grupo_preguntas_id].present?
      GrupoPreguntas.find params[:grupo_preguntas_id]
    else
      GrupoPreguntas.first
    end
  end

  def next_grupo_preguntas!
    @grupo_preguntas = GrupoPreguntas.next_of(params[:grupo_preguntas_id])
  end

  def find_actor
    @actor = Actor.find params[:actor_id]
  end

  def set_active_item
    @active_item = :actores
  end

  def respuesta_params
    params.require(:respuesta).permit(respuesta_preguntas_attributes: [:pregunta_id, :answer])
  end
end
