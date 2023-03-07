class AddPriceToTournaments < ActiveRecord::Migration[7.0]
  def change
    add_column :tournaments, :price, :integer
  end
end
