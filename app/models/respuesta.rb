class Respuesta < ActiveRecord::Base
  belongs_to :user
  belongs_to :actor
  has_many :respuesta_preguntas, dependent: :destroy

  accepts_nested_attributes_for :respuesta_preguntas, reject_if: proc { |attributes| attributes["answer"].blank? }

  def build_for_grupo_preguntas!(grupo_preguntas)
    grupo_preguntas.preguntas.includes(:preguntas).each do |pregunta|
      unless has_respuesta_pregunta_for?(pregunta)
        respuesta_preguntas << RespuestaPregunta.new(respuesta: self, pregunta: pregunta, answer: actor.answer_for(pregunta))
      end
    end
  end

  def has_respuesta_pregunta_for?(pregunta)
    respuesta_preguntas.any? do |respuesta_preguntas|
      respuesta_preguntas.pregunta_id == pregunta
    end
  end
end
