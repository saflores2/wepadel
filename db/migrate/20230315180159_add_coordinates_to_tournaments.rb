class AddCoordinatesToTournaments < ActiveRecord::Migration[7.0]
  def change
    add_column :tournaments, :latitude, :float
    add_column :tournaments, :longitude, :float
  end
end
