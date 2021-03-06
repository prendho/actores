class Respuesta < ActiveRecord::Base
  belongs_to :user
  belongs_to :answerable, polymorphic: true
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
        respuesta_preguntas.build(pregunta: pregunta, answer: answerable.answer_for(pregunta))
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
    # we may need to refactor this
    pregunta = Pregunta.find(attributes["pregunta_id"])
    if attributes["answer"].blank?
      pregunta.write_answer? || attributes["answer"].to_s == answerable.answer_for(pregunta).to_s
    else
      attributes["answer"] == answerable.answer_for(pregunta).to_s
    end
  end
end
