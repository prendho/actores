# encoding: utf-8

class ActorLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :small do
    resize_to_fit(160, 160)
  end

  def public_id
    return model.slug
  end
end
