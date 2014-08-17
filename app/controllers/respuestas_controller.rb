class RespuestasController < ApplicationController
  before_action :require_login

  def index
    redirect_to action: :new, grupo_preguntas_id: params[:grupo_preguntas_id]
  end

  def new
    @grupo_preguntas = GrupoPreguntas.find params[:grupo_preguntas_id] if params[:grupo_preguntas_id].present?
    build_respuestas!
    render :new
  end
  alias_method :show, :new
  alias_method :edit, :new

  def create
    if respuesta.update(respuesta_params)
      flash.now[:notice] = "El formulario ha sido guardado" if only_save?
      build_respuestas!
      track_activity!
    else
      raise "Ups!"
      grupo_preguntas
    end
    if @grupo_preguntas
      render :new
    else
      # the form has been completely fulfilled
      if iniciativa_present?
        redirect_to controller: :iniciativas, action: :show, actor_id: actor.id, id: resource.id
      else
        redirect_to controller: :actores, action: :show, id: actor.id
      end
    end
  end
  alias_method :update, :create

  protected

  def resource
    @resource ||= iniciativa_present? ? iniciativa : actor
  end

  def actor
    @actor ||= Actor.find params[:actor_id]
  end
  helper_method :actor

  def iniciativa
    @iniciativa ||= Iniciativa.find(params[:iniciativa_id]) if iniciativa_present?
  end
  helper_method :iniciativa

  def resource_path
    if resource.is_a?(Actor)
      actor_path(actor, preguntas: params[:grupo_preguntas_id])
    else
      actor_iniciativa_path(actor, iniciativa, preguntas: params[:grupo_preguntas_id])
    end
  end
  helper_method :resource_path

  def breadcrumbs_hash
    @breadcrumbs_hash = [ {name: "Actores", path: actores_path},
                          {name: actor.to_s, path: actor_path(actor)}]
    if iniciativa.present?
      @breadcrumbs_hash << {name: iniciativa.to_s, path: actor_iniciativa_path(actor, iniciativa)}
    end
    @breadcrumbs_hash << grupo_preguntas.to_s
    @breadcrumbs_hash
  end
  helper_method :breadcrumbs_hash

  private

  def iniciativa_present?
    params[:iniciativa_id].present?
  end

  def track_activity!
    recipient = if params[:grupo_preguntas_id].present?
      GrupoPreguntas.find params[:grupo_preguntas_id]
    else
      GrupoPreguntas.first
    end
    # let's keep the activity on the actor to keep it simple
    actor.create_activity :answer, owner: current_user, params: respuesta_params
  end

  def respuesta
    @respuesta ||= if params[:id].present?
      resource.respuestas.for_user(current_user).find(params[:id])
    else
      resource.respuestas.new(user: current_user)
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
        GrupoPreguntas.find(params[:grupo_preguntas_id])
      else
        kind = iniciativa_present? ? :iniciativa : :actor
        GrupoPreguntas.next_of(params[:grupo_preguntas_id], kind)
      end
    else
      GrupoPreguntas.first
    end
  end
  helper_method :grupo_preguntas

  def grupo_preguntas_kind
    grupo_preguntas.kind.to_sym
  end
  helper_method :grupo_preguntas_kind

  def set_active_item
    @active_item = :actores
  end

  def respuesta_params
    params.require(:respuesta).permit(respuesta_preguntas_attributes: [:id, :pregunta_id, :respuesta_id, :answer])
  end
end
