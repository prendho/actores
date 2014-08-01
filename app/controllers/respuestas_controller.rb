class RespuestasController < ApplicationController
  before_action :require_login
  before_action :find_actor

  def new
    @grupo_preguntas = GrupoPreguntas.find params[:grupo_preguntas_id] if params[:grupo_preguntas_id].present?
    build_respuestas!
  end

  def edit
    render :new
  end
  alias_method :show, :edit

  def create
    if respuesta.update(respuesta_params)
      build_respuestas!
    else
      grupo_preguntas
    end
    if @grupo_preguntas
      render :new
    else
      redirect_to controller: :actores, action: :show, id: @actor.id
    end
  end
  alias_method :update, :create

  private

  def respuesta
    @respuesta ||= if params[:id].present?
      @actor.respuestas.for_user(current_user).find(params[:id])
    else
      @actor.respuestas.new(user: current_user)
    end
  end
  helper_method :respuesta

  def respuesta_preguntas
    @respuesta_preguntas ||= @respuesta.respuesta_preguntas
      .to_a
      .sort_by(&:pregunta_id)
      .reject { |respuesta_pregunta|
        !grupo_preguntas_pregunta_ids.include?(respuesta_pregunta.pregunta_id)
      }
  end
  helper_method :respuesta_preguntas

  def grupo_preguntas_pregunta_ids
    @grupo_preguntas_pregunta_ids ||= grupo_preguntas.preguntas.pluck(:id)
  end

  def submit_text
    next_grupo = grupo_preguntas.next
    if next_grupo
      "Siguiente &rsaquo; #{next_grupo}"
    else
      "Enviar y Finalizar"
    end
  end
  helper_method :submit_text

  def build_respuestas!
    respuesta.build_for_grupo_preguntas!(grupo_preguntas) if grupo_preguntas
  end

  def only_save?
    params[:only_save].present?
  end

  def grupo_preguntas
    @grupo_preguntas ||= if params[:grupo_preguntas_id].present?
      if only_save?
        flash.now[:notice] = "El formulario ha sido guardado"
        GrupoPreguntas.find(params[:grupo_preguntas_id])
      else
        GrupoPreguntas.next_of(params[:grupo_preguntas_id])
      end
    else
      GrupoPreguntas.first
    end
  end
  helper_method :grupo_preguntas

  def find_actor
    @actor = Actor.find params[:actor_id]
  end

  def set_active_item
    @active_item = :actores
  end

  def respuesta_params
    params.require(:respuesta).permit(respuesta_preguntas_attributes: [:id, :pregunta_id, :respuesta_id, :answer])
  end
end
