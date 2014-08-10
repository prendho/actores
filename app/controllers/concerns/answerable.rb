module Answerable
  extend ActiveSupport::Concern

  included do
    helper_method :grupo_preguntas, :grupo_preguntas_kind
  end

  private

  def grupo_preguntas
    @grupo_preguntas ||= if params[:preguntas].present?
      GrupoPreguntas.find(params[:preguntas])
    else
      GrupoPreguntas
        .send(grupo_preguntas_kind)
        .first
    end
  end
end
