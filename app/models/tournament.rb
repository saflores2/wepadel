class Tournament < ApplicationRecord
  belongs_to :user
  belongs_to :ubication
  has_many :participations, dependent: :destroy
end


