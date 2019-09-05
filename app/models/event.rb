# frozen_string_literal: true

load 'image_uploader.rb'

class Event < ApplicationRecord
  include Activable
  belongs_to :chapter
  has_many :event_monsters, dependent: :destroy
  has_many :monsters, through: :event_monsters

  has_many :turns

  has_many :rewards, dependent: :destroy
  has_many :stuffs, through: :rewards

  has_many :messages

  delegate :world, to: :chapter

  mount_uploader :image, EventImageUploader

  before_create :start_turn

  def start_turn
    turns.new
  end

  def grouped_monsters
    event_monsters.group_by(&:monster_id)
  end

  def current_turn
    turns.where(finished: 0).first
  end

  def pass_turn
    current_turn.finish!
    world.characters.find_all.map(&:has_not_played!)
    world.current_event.event_monsters.find_all.map(&:has_not_played!)
    turns.new.save
  end
end
