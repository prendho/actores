class Respuesta < ActiveRecord::Base
  belongs_to :user
  belongs_to :actor
  has_many :respuesta_preguntas, dependent: :destroy
end
