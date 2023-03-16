class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :status
      t.string :status_detail
      t.integer :mp_id

      t.timestamps
    end
  end
end
