# frozen_string_literal: true

load 'image_uploader.rb'

class Character < ApplicationRecord
  include Fighter
  include Player
  include Narrator
  include Stuffable
  include Sluggable

  belongs_to :user
  belongs_to :character_type
  belongs_to :world

  has_many :fights, as: :attacker
  has_many :fights, as: :defender

  has_many :messages
  has_many :inventories, dependent: :destroy
  has_many :stuffs, through: :inventories

  mount_uploader :image, ChapterImageUploader

  validate :user_not_in_world, on: :create
  # validate :user_not_world_game_master, on: :create
  # validate :world_not_full, on: :create
  validates_uniqueness_of :name

  def user_not_in_world
    unless user.joined_worlds.empty?
      if user.joined_worlds.pluck(:id).include?(world.id)
        errors.add(:user, 'is in world')
      end
    end
  end

  def user_not_world_game_master
    unless user.joined_worlds.empty?
      if user.worlds.pluck(:id).include?(world.id)
        errors.add(:user, 'is game master')
      end
    end
  end

  def world_not_full
    errors.add(:world, 'is full') if world.max_character_count == world.characters.count
  end

  def current_life
    life - malus_life
  end

  def life
    character_type.life + bonus_life + life_stuffs_bonus
  end

  def armor
    character_type.armor + bonus_armor + armor_stuffs_bonus
  end

  def attack_min
    character_type.attack_min + bonus_attack + attack_stuffs_bonus
  end

  def attack_max
    character_type.attack_max + bonus_attack + attack_stuffs_bonus
  end
end
