class RemoveLatFromTournaments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tournaments, :lat, :float
  end
end
