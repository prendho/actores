class Actor < ActiveRecord::Base
# relationships
  has_many :users
  has_many :respuestas

# validations
  validates :nombre, presence: true, uniqueness: true
end
