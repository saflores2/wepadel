class RemoveLngFromTournaments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tournaments, :lng, :float
  end
end
