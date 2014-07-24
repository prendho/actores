class UsersJob
  include SuckerPunch::Job

  def invite(user)
    UserMailer.invite(user).deliver
  end

  def deliver_reset_password_instructions!(user)
    user.deliver_reset_password_instructions!
  end
end
