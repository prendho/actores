module AnswerableModel
  extend ActiveSupport::Concern

  included do
    has_many :respuestas, as: :answerable
    has_many :respuesta_preguntas, through: :respuestas
  end

  def answer_for(pregunta)
    respuesta_preguntas.where(pregunta: pregunta).last.try :answer
  end
end
