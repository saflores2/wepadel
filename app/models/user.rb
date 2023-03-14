class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :participations, class_name: 'Participation',
                            foreign_key: 'user_id'
  has_many :partner_participations, class_name: 'Participation',
                                    foreign_key: 'partner_id'

  has_many :tournaments, through: :participations
  has_many :chatrooms, through: :tournaments
  has_many :partner_tournaments, through: :partner_participations, source: :tournament
  validates :name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_many :messages
end
