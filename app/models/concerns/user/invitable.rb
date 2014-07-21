class User < ActiveRecord::Base
  module Invitable
    extend ActiveSupport::Concern

    included do
      validates :invitation_token, uniqueness: true, allow_blank: true

      attr_accessor :will_invite

      before_save :user_will_be_invited
    end

    private

    def user_will_be_invited
      if will_invite
        generate_invitation_token!
        send_invitation_email!
      end
    end

    def generate_invitation_token!
      self.invitation_token_expires_at = 1.month.from_now
      begin
        self.invitation_token = SecureRandom.hex(30)
      end while self.class.exists?(invitation_token: invitation_token)
    end

    def send_invitation_email!
      UserInvitationMailerJob.new.async.perform(self)
    end
  end
end
