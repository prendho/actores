class AddKindToGrupoPreguntas < ActiveRecord::Migration
  def change
    add_column :grupos_preguntas, :kind, :integer
    add_index :grupos_preguntas, :kind
  end
end
