class AddInvitationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_token_expires_at, :datetime
  end
end
