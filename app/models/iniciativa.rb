class Iniciativa < ActiveRecord::Base
  belongs_to :actor, counter_cache: true

  validates :nombre, presence: true
  validates :actor_id, presence: true

  def to_s
    nombre
  end
end
