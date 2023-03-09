class AddKeysForParticipations < ActiveRecord::Migration[7.0]
  def change
    add_reference :participations, :partner, index: true, null: true
  end
end
