class Pregunta < ActiveRecord::Base
  enum kind: [:write_answer, :option, :multiple_option]

  belongs_to :grupo_preguntas
  has_many :pregunta_options, dependent: :destroy
  has_many :respuesta_preguntas, dependent: :destroy

  validates :title, presence: true

  serialize :children_ids

  after_save :set_other_pregunta_option_id

  def children=(children_attrs)
    self.children_ids = children_attrs.map do |attrs|
      Pregunta.create!(attrs).id
    end
  end

  def options=(options_attrs)
    self.pregunta_options = options_attrs.map do |answer|
      PreguntaOption.new(answer: answer, pregunta: self)
    end
  end

  private

  def set_other_pregunta_option_id
    if allow_other && other_pregunta_option_id.nil?
      update! other_pregunta_option_id: pregunta_options.last.id
    end
  end
end
