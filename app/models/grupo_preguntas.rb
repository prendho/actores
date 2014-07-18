class GrupoPreguntas < ActiveRecord::Base
  has_many :preguntas, dependent: :destroy
end
