class Iniciativa < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :actor, counter_cache: true
  has_many :respuestas, as: :answerable

  validates :nombre, presence: true
  validates :actor_id, presence: true

  def to_s
    nombre
  end
end
