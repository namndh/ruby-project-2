# encoding: utf-8

class SongUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(mp3)
  end

  def default_url
    "missing.jpg"
  end

end
