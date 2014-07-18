class Actor < ActiveRecord::Base
  scope :sorted, -> { order(:nombre) }

# relationships
  has_many :users
  has_many :respuestas

# validations
  validates :nombre, presence: true, uniqueness: true

  def to_s
    nombre
  end
end
