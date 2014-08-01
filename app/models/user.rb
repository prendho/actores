require 'digest/md5'

class User < ActiveRecord::Base
  include Invitable
  include PublicActivity::Common

  authenticates_with_sorcery!

# relationships
  belongs_to :actor
  has_many :respuestas

  validates :email, uniqueness: true, presence: true
  validate :validate_password_confirmation
  validate :validate_password_presence

  attr_accessor :password_confirmation
  attr_accessor :require_password

# methods
  def to_s
    nombres.blank? ? email : nombres
  end

  def email_or_rand
    email.blank? ? random_str : email
  end

  def random_str
    (0...8).map { (65 + rand(26)).chr }.join
  end

  def gravatar(size=80)
    hash = Digest::MD5.hexdigest(email_or_rand)
    "http://www.gravatar.com/avatar/#{hash}?d=retro&s=#{size}"
  end

  def async_deliver_reset_password_instructions!
    UsersJob.new.async.deliver_reset_password_instructions!(self)
  end

  private

  def validate_password_confirmation
    if password.present?
      errors.add(:password_confirmation, "las contraseñas no coinciden") if password_confirmation != password
    end
  end

  def validate_password_presence
    if require_password
      self.require_password = false
      errors.add(:password, "no puede estar en blanco") if password.blank?
    end
  end
end
