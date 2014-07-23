class RespuestaPregunta < ActiveRecord::Base
  belongs_to :respuesta
  belongs_to :pregunta

  def answered?(option)
    if option.other?
      !pregunta.pregunta_options.pluck(:answer).include?(answer) && !answer.blank?
    else
      answer == option.answer
    end
  end
end
