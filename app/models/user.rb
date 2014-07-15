require 'digest/md5'

class User < ActiveRecord::Base
  authenticates_with_sorcery!

# methods
  def to_s
    nombres or email
  end

  def gravatar
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?d=wavatar"
  end
end
