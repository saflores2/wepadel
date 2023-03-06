class AddStatusToParticipation < ActiveRecord::Migration[7.0]
  def change
    add_column :participations, :status, :string
  end
end
