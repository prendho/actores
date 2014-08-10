class GrupoPreguntas < ActiveRecord::Base
  enum kind: [:actor, :iniciativa]

  has_many :preguntas, dependent: :destroy

  def to_s
    title
  end

  def next
    self.class.next_of(id)
  end

  def number_and_title
    "#{number}. #{title}"
  end

  def number
    self.class.pluck(:id).index(id) + 1
  end

  def self.next_of(id)
    where("id > ?", id).first
  end
end
