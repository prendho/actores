# encoding: utf-8
class UserInvitationMailer < ActionMailer::Base
  default from: "noreply@example.com"

  def invite(user)
    @user = user
    mail(subject: "Invitación", to: @user.email)
  end
end
