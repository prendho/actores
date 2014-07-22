class Pregunta < ActiveRecord::Base
  enum kind: [:write_answer, :option, :multiple_option]

  scope :roots, -> { where(parent_id: nil) }

  belongs_to :grupo_preguntas
  belongs_to :parent, class_name: Pregunta, foreign_key: :parent_id
  has_many :pregunta_options, dependent: :destroy
  has_many :respuesta_preguntas, dependent: :destroy

  validates :title, presence: true

  after_save :set_other_pregunta_option_id

  def children=(children_attrs)
    children_attrs.each do |attrs|
      Pregunta.create!(attrs.merge(parent: self))
    end
  end

  def options=(options_attrs)
    self.pregunta_options = options_attrs.map do |answer|
      PreguntaOption.new(answer: answer, pregunta: self)
    end
  end

  def to_s
    title
  end

  def number_and_title
    "#{grupo_preguntas.number}.#{number}. #{title}"
  end

  def number
    grupo_preguntas.preguntas.pluck(:id).index(id) + 1
  end

  private

  def set_other_pregunta_option_id
    if allow_other && other_pregunta_option_id.nil?
      update! other_pregunta_option_id: pregunta_options.last.id
    end
  end
end
