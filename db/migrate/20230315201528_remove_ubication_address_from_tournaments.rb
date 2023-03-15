class RemoveUbicationAddressFromTournaments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tournaments, :ubication_address, :string
  end
end
