class Iniciativa < ActiveRecord::Base
  belongs_to :actor

  validates :nombre, presence: true
  validates :actor_id, presence: true
end
