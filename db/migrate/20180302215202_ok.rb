class Ok < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :sn
      t.integer :value
      t.string :description
      t.string :picture_url
      t.belongs_to :local

      t.timestamps
    end
  end
end
