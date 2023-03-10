class ChangeKeysForParticipations < ActiveRecord::Migration[7.0]
  def change
    remove_reference :participations, :partner, index: true
  end
end
