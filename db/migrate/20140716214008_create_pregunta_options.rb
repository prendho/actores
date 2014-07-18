class CreatePreguntaOptions < ActiveRecord::Migration
  def change
    create_table :pregunta_options do |t|
      t.string :answer
      t.integer :pregunta_id, null: false
    end
    add_index :pregunta_options, :pregunta_id
  end
end
