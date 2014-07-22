class RespuestaPregunta < ActiveRecord::Base
  belongs_to :respuesta
  belongs_to :pregunta

  validates :answer, presence: true

  def answered?(option)
    if option.other?
      !pregunta.pregunta_options.pluck(:answer).include?(answer)
    else
      answer == option.answer
    end
  end
end
