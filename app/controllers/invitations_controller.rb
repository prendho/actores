class InvitationsController < ApplicationController
  def show
    @user = User.find_by! invitation_token: params[:id]
    render :expired if Time.now > @user.invitation_token_expires_at 
  end
end
