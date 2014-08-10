class CreateIniciativas < ActiveRecord::Migration
  def change
    create_table :iniciativas do |t|
      t.integer :actor_id, null: false
      t.string :nombre, null: false
      t.text :descripcion
      t.timestamps
    end
    add_index :iniciativas, :actor_id
  end
end
