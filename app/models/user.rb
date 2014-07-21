require 'digest/md5'

class User < ActiveRecord::Base
  include Invitable

  authenticates_with_sorcery!

# relationships
  belongs_to :actor
  has_many :respuestas

# methods
  def to_s
    nombres or email
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
end
