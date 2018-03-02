class CreateLocals < ActiveRecord::Migration[5.1]
  def change
    create_table :locals do |t|
      t.string :name
      t.string :max
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
