class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :worlds
  has_many :characters, dependent: :destroy

  def joined_worlds_id
    self.characters.map{ |character| character.world.id }
  end

  def joined_world_id?(world_id)
    self.joined_worlds_id.include?(world_id)
  end

  def character_for_world_id(world_id)
    CharacterType.joins(:characters).where( 'character_types.world_id' => world_id)
      .where( 'characters.user_id' => self.id )

    # world.character_types.characters.where(user: self).first
  end
end
