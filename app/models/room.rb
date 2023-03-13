class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }
  # cuando se crea un nuevo room se actualizan los rooms automaticamente
  after_create_commit { broadcast_append_to "rooms" }
  has_many :messages
end
