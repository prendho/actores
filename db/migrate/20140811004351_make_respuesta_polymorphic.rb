class MakeRespuestaPolymorphic < ActiveRecord::Migration
  def up
    remove_index :respuestas, [:user_id, :actor_id]
    change_table :respuestas do |t|
      t.rename :actor_id, :answerable_id
      t.string :answerable_type
    end
    add_index :respuestas, [:user_id, :answerable_id, :answerable_type], name: :respuestas_polymorphic
    Respuesta.reset_column_information
    Respuesta.update_all answerable_type: "Actor"
  end

  def down
    remove_index :respuestas, name: :respuestas_polymorphic
    change_table :respuestas do |t|
      t.remove :answerable_type
      t.rename :answerable_id, :actor_id
    end
    add_index :respuestas, [:user_id, :actor_id]
  end
end
