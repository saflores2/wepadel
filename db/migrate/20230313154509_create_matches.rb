class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :first_team, null: true
      t.references :second_team, null: true
      t.integer :round
      t.integer :match_number
      t.references :winner, null: true
      t.string :first_team_name
      t.string :second_team_name

      t.timestamps
    end
      add_foreign_key :matches, :participations, column: :first_team_id
      add_foreign_key :matches, :participations, column: :second_team_id
      add_foreign_key :matches, :participations, column: :winner_id
  end
end
