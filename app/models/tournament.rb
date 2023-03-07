class Tournament < ApplicationRecord
  belongs_to :user
  self.inheritance_column = :foo
  has_many :participations, dependent: :destroy
  has_one_attached :photo
  validates_inclusion_of :type, in: ["Champions League", "Americano", "Express"]
end
