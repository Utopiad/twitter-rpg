# frozen_string_literal: true

class WorldImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :form_preview do
      process resize_to_fit: [165, 165]
    end
    version :cards do
      process resize_to_fit: [318, 165]
    end
    version :list_cards do
      process resize_to_fit: [951, 99]
    end
    version :large_banner do
      process resize_to_fit: [1440, 389]
    end
    version :thin_banner do
      process resize_to_fit: [1440, 119]
    end
  end
end

class ChapterImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb do
      process resize_to_fit: [35, 35]
    end
    version :form_preview do
      process resize_to_fit: [105, 105]
    end
  end
end

class EventImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb do
      process resize_to_fit: [35, 35]
    end
    version :cards do
      process resize_to_fit: [234, 176]
    end
    version :form_preview do
      process resize_to_fit: [105, 105]
    end
  end
end

class MonsterImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb do
      process resize_to_fit: [35, 35]
    end
    version :form_preview do
      process resize_to_fit: [105, 105]
    end
  end
end

class StuffImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb do
      process resize_to_fit: [35, 35]
    end
    version :cards do
      process resize_to_fit: [55, 55]
    end
  end
end

class CharacterImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb do
      process resize_to_fit: [50, 50]
    end
  end
end

class UserImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb do
      process resize_to_fit: [45, 45]
    end
  end
end
