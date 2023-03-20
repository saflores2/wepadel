class ChancheColumPayments < ActiveRecord::Migration[7.0]
  def change
    change_column :payments, :mp_id, :string
  end
end
