class AllowUsersWithoutPassword < ActiveRecord::Migration
  def up
    change_column :users, :crypted_password, :string, null: true
    change_column :users, :salt, :string, null: true
  end

  def down
    change_column :users, :crypted_password, :string, null: false
    change_column :users, :salt, :string, null: false
  end
end
