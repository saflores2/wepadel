class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :first_team, class_name: 'Participation', optional: true
  belongs_to :second_team, class_name: 'Participation', optional: true
  belongs_to :winner, class_name: 'Participation', optional: true
  has_many :games, dependent: :destroy
end
