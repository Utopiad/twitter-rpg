class Character < ApplicationRecord
  include Fighter
  include Stuffable
  belongs_to :user
  belongs_to :character_type

  has_many :fights, as: :attacker
  has_many :fights, as: :defender
  has_many :messages
  has_many :inventories, dependent: :destroy
  has_many :stuffs, through: :inventories

  delegate :world, :to => :character_type

  validate :user_not_in_world, on: :create
  validate :user_not_world_game_master, on: :create
  validate :world_not_full, on: :create

  def user_not_in_world
    errors.add(:user, "is in world") if user.joined_worlds.pluck(:id)
      .include?(self.world.id)
  end

  def user_not_world_game_master
    errors.add(:user, "is game master") if user.worlds.include?(self.world.id)
  end

  def world_not_full
    errors.add(:world, "is full") if world.max_character_count == world.characters.count
  end

  def current_life
    self.character_type.life + self.life - self.malus_life
  end

  def life
    self.character_type.life + self.bonus_life + self.life_stuffs_bonus
  end

  def armor
    self.character_type.armor + self.bonus_armor + self.armor_stuffs_bonus
  end

  def attack_min
    self.character_type.attack_min + self.bonus_attack + self.attack_stuffs_bonus
  end

  def attack_max
    self.character_type.attack_max + self.bonus_attack + self.attack_stuffs_bonus
  end
end
