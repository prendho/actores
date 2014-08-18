class AddIndexToIniciativa < ActiveRecord::Migration
  def change
    add_index :iniciativas, :nombre
  end
end
