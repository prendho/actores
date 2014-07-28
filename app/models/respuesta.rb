class Respuesta < ActiveRecord::Base
  belongs_to :user
  belongs_to :actor
  has_many :respuesta_preguntas, dependent: :destroy

  scope :for_user, ->(user) { where(user: user) }

  accepts_nested_attributes_for :respuesta_preguntas, reject_if: :reject_respuesta_pregunta?

  def answer_for(pregunta)
    respuesta_preguntas.where(pregunta_id: pregunta.id).first.try :answer
  end

  def build_for_grupo_preguntas!(grupo_preguntas)
    grupo_preguntas.preguntas
      .includes(:pregunta_options).includes(preguntas: :parent)
      .each do |pregunta|
      unless has_respuesta_pregunta_for?(pregunta)
        respuesta_preguntas << RespuestaPregunta.new(respuesta: self, pregunta: pregunta, answer: actor.answer_for(pregunta))
      end
    end
  end

  private

  def has_respuesta_pregunta_for?(pregunta)
    respuesta_preguntas.any? do |respuesta_preguntas|
      respuesta_preguntas.pregunta_id == pregunta.id
    end
  end

  def reject_respuesta_pregunta?(attributes)
    pregunta = Pregunta.find(attributes["pregunta_id"])
    if attributes["answer"].blank?
      pregunta.kind == "write_answer"
    else
      actor.answer_for(pregunta).to_s == attributes["answer"]
    end
  end
end
