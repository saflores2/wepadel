class AddColumnsToChatroom < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :tournament, null: true, foreign_key: true
    add_reference :chatrooms, :user, null: true, foreign_key: true
  end
end
