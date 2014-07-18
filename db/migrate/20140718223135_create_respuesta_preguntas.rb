class CreateRespuestaPreguntas < ActiveRecord::Migration
  def change
    create_table :respuesta_preguntas do |t|
      t.integer :pregunta_id
      t.integer :respuesta_id
      t.text :answer
    end
    add_index :respuesta_preguntas, [:pregunta_id, :respuesta_id]
  end
end
