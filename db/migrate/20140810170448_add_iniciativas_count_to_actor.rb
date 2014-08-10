class AddIniciativasCountToActor < ActiveRecord::Migration
  def change
    add_column :actores, :iniciativas_count, :integer, default: 0
  end
end
