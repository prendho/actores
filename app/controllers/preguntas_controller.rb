class PreguntasController < ApplicationController
  attr_reader :actor
  helper_method :actor

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

  def resource_pregunta_path
    if iniciativa.present?
      actor_iniciativa_path(@actor, iniciativa, preguntas: grupo_preguntas.id)
    else
      actor_path(@actor, preguntas: grupo_preguntas.id)
    end
  end

  def breadcrumbs_hash
    @hash = [ {name: "Actores", path: actores_path},
              {name: actor.to_s, path: actor_path(actor)} ]
    if iniciativa.present?
      @hash << {name: iniciativa.to_s, path: actor_iniciativa_path(actor, iniciativa)}
    end
    @hash << {name: grupo_preguntas.to_s, path: resource_pregunta_path}
    @hash << @pregunta.to_s
    @hash
  end
  helper_method :breadcrumbs_hash
end
