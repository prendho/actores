class GrupoPreguntas < ActiveRecord::Base
  has_many :preguntas, dependent: :destroy

  scope :next_of, ->(id) {
    where("id > ?", id).first
  }

  def to_s
    title
  end

  def number_and_title
    "#{number}. #{title}"
  end

  def number
    self.class.pluck(:id).index(id) + 1
  end
end
