class WorldImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # version :print do
  #   version :thumb    { process :resize_to_fit => [32, 32] }
  #   version :preview  { process :resize_to_fit => [256, 256] }
  #   version :full     { process :resize_to_fit => [2048, 2048] }
  # end
  #
  # version :web do
  #   version :thumb    { process :resize_to_fit => [32, 32] },
  #   version :preview  { process :resize_to_fit => [128, 128] },
  #   version :full     { process :resize_to_fit => [1024, 768] }
  # end

  version :print do
    version :thumb do
      process :resize_to_fit => [32, 32]
    end
    version :preview do
      process :resize_to_fit => [256, 256]
    end
    version :full do
      process :resize_to_fit => [2048, 2048]
    end
  end

  version :web do
    version :thumb do
      process :resize_to_fit => [32, 32]
    end
    version :preview do
      process :resize_to_fit => [128, 128]
    end
    version :full do process :resize_to_fit => [1024, 768]
    end
  end

end