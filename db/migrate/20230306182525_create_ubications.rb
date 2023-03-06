class CreateUbications < ActiveRecord::Migration[7.0]
  def change
    create_table :ubications do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
