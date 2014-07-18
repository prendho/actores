class RespuestaPregunta < ActiveRecord::Base
  belongs_to :respuesta
  belongs_to :pregunta
end
