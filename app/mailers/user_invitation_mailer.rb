# encoding: utf-8
class UserInvitationMailer < ActionMailer::Base
  default from: "bot"

  def invite(user)
    @user = user
    mail(subject: "Invitación", to: "#{@user.nombres} <#{@user.email}>")
  end
end
