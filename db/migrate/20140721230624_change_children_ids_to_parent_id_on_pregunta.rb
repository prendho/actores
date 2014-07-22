class ChangeChildrenIdsToParentIdOnPregunta < ActiveRecord::Migration
  def up
    remove_column :preguntas, :children_ids
    add_column :preguntas, :parent_id, :integer
    add_index :preguntas, :parent_id
  end

  def down
    remove_index :preguntas, :parent_id
    remove_column :preguntas, :parent_id
    add_column :preguntas, :children_ids, :string
  end
end
