class GrupoPreguntas < ActiveRecord::Base
  enum kind: [:actor, :iniciativa]

  has_many :preguntas, dependent: :destroy

  def to_s
    title
  end

  def next
    self.class.next_of(id, kind)
  end

  def number_and_title
    "#{number}. #{title}"
  end

  def number
    self.class.send(kind).pluck(:id).index(id) + 1
  end

  def sorted_preguntas
    @sorted_preguntas ||= preguntas.to_a.sort_by(&:id)
  end

  def self.next_of(id, kind)
    send(kind).where("id > ?", id).first
  end
end
