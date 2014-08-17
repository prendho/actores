class PreguntasController < ApplicationController
  attr_reader :actor

  before_action :require_login
  before_action :require_admin
  before_action :find_actor

  def show
    @pregunta = Pregunta.find params[:id]
  end

  private

  def find_actor
    @actor = Actor.find params[:actor_id]
  end

  def set_active_item
    @active_item = :actores
  end

  def grupo_preguntas
    @grupo_preguntas ||= @pregunta.grupo_preguntas
  end
  helper_method :grupo_preguntas

  def iniciativa
    @iniciativa ||= Iniciativa.find(params[:iniciativa_id]) if params[:iniciativa_id].present?
  end
  helper_method :iniciativa

  def resource
    iniciativa or actor
  end
  helper_method :resource

  def pregunta_path
    if iniciativa.present?
      actor_iniciativa_path(@actor, iniciativa, preguntas: grupo_preguntas.id)
    else
      actor_path(@actor, preguntas: grupo_preguntas.id)
    end
  end
  helper_method :pregunta_path
end
