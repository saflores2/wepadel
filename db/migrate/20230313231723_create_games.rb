class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :games_first_team
      t.integer :games_second_team
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
