class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tournaments
  has_many :participations, class_name: 'Participation',
                            foreign_key: 'user_id'
  has_many :payee_payments, class_name: 'Participation',
                            foreign_key: 'partner_id'
end
