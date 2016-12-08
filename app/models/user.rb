class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :worlds
  has_many :characters, dependent: :destroy
  has_many :joined_worlds, through: :characters, foreign_key: "world_id", source: :world
end
