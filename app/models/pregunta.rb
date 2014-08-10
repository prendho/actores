class Pregunta < ActiveRecord::Base
  enum kind: [:write_answer, :option, :multiple_option]

  scope :roots, -> { where(parent_id: nil) }
  scope :children, -> { where.not(parent_id: nil) }

  belongs_to :grupo_preguntas
  belongs_to :parent, class_name: Pregunta, foreign_key: :parent_id
  has_many :preguntas, class_name: Pregunta, foreign_key: :parent_id
  has_many :pregunta_options, dependent: :destroy
  has_many :respuesta_preguntas, dependent: :destroy
  has_many :respuestas, through: :respuesta_preguntas

  validates :title, presence: true

  before_save :set_parent_grupo_pregunta_id, if: :is_child?
  after_save :set_other_pregunta_option_id

  def children=(children_attrs)
    children_attrs.each do |attrs|
      Pregunta.create!(attrs.merge(parent: self, grupo_preguntas: grupo_preguntas))
    end
  end

  def has_children?
    preguntas.length > 0
  end

  def is_child?
    !parent_id.blank?
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
    if parent_id.blank?
      grupo_preguntas.preguntas.roots.pluck(:id).index(id) + 1
    else
      child_number = parent.preguntas.pluck(:id).index(id) + 1
      "#{parent.number}.#{child_number}"
    end
  end

  def answerers_for(actor)
    User.where id: answers_for(actor).pluck(:user_id)
  end

  def answers_for(actor)
    respuestas.where(actor_id: actor.id)
  end

  private

  def set_other_pregunta_option_id
    if allow_other && other_pregunta_option_id.nil?
      update! other_pregunta_option_id: pregunta_options.last.id
    end
  end

  def set_parent_grupo_pregunta_id
    raise "Ups!" unless is_child?
    self.grupo_preguntas_id = parent.grupo_preguntas_id
  end
end
