class RemovePlaceFromTournaments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tournaments, :place, :integer
  end
end
