class Participation < ApplicationRecord
  belongs_to :tournament
  belongs_to :user, class_name: 'User'
  belongs_to :partner, class_name: 'User', optional: true
  has_one :payment
end
