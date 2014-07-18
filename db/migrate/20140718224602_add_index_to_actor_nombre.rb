class AddIndexToActorNombre < ActiveRecord::Migration
  def change
    add_index :actores, :nombre
  end
end
