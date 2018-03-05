class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :vehicle, foreign_key: true
      t.belongs_to :local, foreign_key: true
      t.string :local_drop
      t.string :due_date
      t.string :drop_date
      t.string :price

      t.timestamps
    end
  end
end
