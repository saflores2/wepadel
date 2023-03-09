class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :tournaments

  has_many :participations, class_name: 'Participation',
                            foreign_key: 'user_id'
  has_many :participations, class_name: 'Participation',
                            foreign_key: 'partner_id'
  validates :name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
