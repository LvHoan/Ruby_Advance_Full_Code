# frozen_string_literal: true

module Logic
  class SendSingleEmailJob < ApplicationJob
    queue_as :default

    def perform(user_id, subject, title, content)
      user = User.find(user_id)
      NotificationMailer.general_announcement(
        user,
        subject,
        { title: title, content: content }
      ).deliver_now
    end
  end
end
