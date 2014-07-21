class UserInvitationMailerJob
  include SuckerPunch::Job

  def perform(user)
    UserInvitationMailer.invite(user).deliver
  end
end
