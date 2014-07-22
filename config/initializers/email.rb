ActionMailer::Base.smtp_settings = {
  address: Rails.application.secrets[:smtp_address],
  port: Rails.application.secrets[:smtp_port] || 587,
  domain: Rails.application.secrets[:smtp_domain] || Rails.application.secrets[:app_domain],
  user_name: Rails.application.secrets[:smtp_user],
  password: Rails.application.secrets[:smtp_password],
  authentication: "plain"
}
