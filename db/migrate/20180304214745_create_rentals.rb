class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :vehicle, foreign_key: true
      t.integer :price
      t.string :due_date
      t.string :dropped_date

      t.timestamps
    end
  end
end
