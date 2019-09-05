# frozen_string_literal: true

load 'image_uploader.rb'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :worlds
  has_many :characters, dependent: :destroy

  mount_uploader :image, UserImageUploader

  def joined_worlds
    characters.map(&:world)
  end

  def character_for_world_id(world_id)
    characters.where(world_id: world_id).first
  end
end
