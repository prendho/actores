class AddExtraInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :nombres, :string
    add_column :users, :admin, :boolean
    add_index :users, :admin
    add_column :users, :actor_id, :integer
    add_index :users, :actor_id
  end
end
