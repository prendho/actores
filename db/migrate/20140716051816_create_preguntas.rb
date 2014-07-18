class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.string :title, null: false
      t.boolean :allow_other, default: false
      t.integer :other_pregunta_option_id
      t.integer :grupo_preguntas_id
      t.integer :kind, default: 0
      t.string :children_ids
    end
    add_index :preguntas, :grupo_preguntas_id
  end
end
