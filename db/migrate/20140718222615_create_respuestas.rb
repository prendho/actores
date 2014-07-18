class CreateRespuestas < ActiveRecord::Migration
  def change
    create_table :respuestas do |t|
      t.integer :user_id
      t.integer :actor_id

      t.timestamps
    end
    add_index :respuestas, [:user_id, :actor_id]
  end
end
