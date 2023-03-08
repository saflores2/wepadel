class ChangeColumnsInTournaments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tournaments, :gender
    add_column :tournaments, :available_places, :integer
    change_column :tournaments, :duration, :string
    change_column :tournaments, :match_duration, :string
  end
end
