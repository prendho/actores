class RespuestaPregunta < ActiveRecord::Base
  belongs_to :respuesta
  belongs_to :pregunta

  validate :allow_blank_if_multiple_option

  def answered?(option)
    if option.other?
      !pregunta.pregunta_options.pluck(:answer).include?(answer) && !answer.blank?
    else
      answer == option.answer
    end
  end

  private

  def allow_blank_if_multiple_option
    errors.add(:answer, "no puede estar en blanco") if answer.blank? && pregunta.kind != "multiple_option"
  end
end
