class Actor < ActiveRecord::Base
  scope :sorted, -> { order(:nombre) }

# relationships
  has_many :users
  has_many :respuestas
  has_many :respuesta_preguntas, through: :respuestas

# validations
  validates :nombre, presence: true, uniqueness: true

  def to_s
    nombre
  end

  def logo_url
    "/images/actores/#{slug}.png"
  end

  def slug
    acronimo.try(:parameterize) or nombre.parameterize
  end

  def answer_for(pregunta)
    respuesta_preguntas.where(pregunta: pregunta).last.try :answer
  end
end
