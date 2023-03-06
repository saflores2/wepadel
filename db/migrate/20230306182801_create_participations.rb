class CreateParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :participations do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :user, null: false#, foreign_key: true
      t.references :partner, null: false
      t.string :partner_email

      t.timestamps
    end
    add_foreign_key :participations, :users, column: :user_id
    add_foreign_key :participations, :users, column: :partner_id
  end
end
