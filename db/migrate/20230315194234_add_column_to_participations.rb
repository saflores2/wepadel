class AddColumnToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_reference :participations, :payment, index: true, null: true
  end
end
