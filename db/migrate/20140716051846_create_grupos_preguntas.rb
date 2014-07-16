class CreateGruposPreguntas < ActiveRecord::Migration
  def change
    create_table :grupos_preguntas do |t|
      t.string :title

      t.timestamps
    end
  end
end
