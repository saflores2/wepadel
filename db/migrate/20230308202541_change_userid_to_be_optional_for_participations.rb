class ChangeUseridToBeOptionalForParticipations < ActiveRecord::Migration[7.0]
  def change
    # change_column :participations, :partner, :references, null: true
  end
end
