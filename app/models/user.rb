class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :worlds
  has_many :characters, dependent: :destroy

  def joined_worlds
    self.characters.map{ |c| c.world }
  end
end
