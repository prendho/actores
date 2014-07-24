class UserMailer < ActionMailer::Base
  default from: "bot@aei.prendho.com"

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail(subject: "#{Rails.application.secrets[:app_domain]} - Recuperar tu contraseña", to: user.email)
  end

  def invite(user)
    @user = user
    mail(subject: "Invitación", to: "#{@user.nombres} <#{@user.email}>")
  end
end
