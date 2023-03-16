class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :tournament
  # validates_uniqueness_of :name

  after_create_commit { broadcast_append_to "chatrooms" }
end
