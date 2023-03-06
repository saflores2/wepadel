class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ubication, null: false, foreign_key: true
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.float :duration
      t.string :type
      t.string :category
      t.string :gender
      t.integer :min_matches
      t.integer :max_matches
      t.integer :place
      t.float :match_duration
      t.string :awards
      t.string :other

      t.timestamps
    end
  end
end
