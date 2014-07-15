class CreateActores < ActiveRecord::Migration
  def change
    create_table :actores do |t|
      t.string :nombre, null: false
      t.string :acronimo
      t.string :logo
      t.timestamps
    end
  end
end
