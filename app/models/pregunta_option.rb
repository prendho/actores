class PreguntaOption < ActiveRecord::Base
  belongs_to :pregunta

  def to_s
    answer
  end

  def other?
    pregunta.other_pregunta_option_id == id
  end
end
