class PreguntasController < ApplicationController
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
end
