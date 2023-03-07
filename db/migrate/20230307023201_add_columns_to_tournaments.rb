class AddColumnsToTournaments < ActiveRecord::Migration[7.0]
  def change
    add_column :tournaments, :places, :integer
    add_column :tournaments, :ubication_name, :string
    add_column :tournaments, :ubication_address, :string
    add_column :tournaments, :lat, :float
    add_column :tournaments, :lng, :float
  end
end
