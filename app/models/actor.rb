class Actor < ActiveRecord::Base
  include PublicActivity::Common
  include AnswerableModel

  scope :sorted, -> { order(iniciativas_count: :desc).order(:nombre) }
  scope :like, ->(query) { where("nombre ILIKE :query OR acronimo ILIKE :query", query: "%#{query}%") }

# relationships
  has_many :users
  has_many :iniciativas

# validations
  validates :nombre, presence: true, uniqueness: true

  mount_uploader :logo, ActorLogoUploader

  def to_s
    nombre
  end

  def logo_image_url
    logo_url(:small) or default_logo_url
  end

  def slug
    acronimo.try(:parameterize) or nombre.parameterize
  end
end
