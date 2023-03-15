class AddColumnAddressToTournaments < ActiveRecord::Migration[7.0]
  def change
    add_column :tournaments, :address, :string
  end
end
