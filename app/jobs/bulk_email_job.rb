class BulkEmailJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 100

  def perform(subject, content)
    title = EmailConstants::BULK_ANNOUNCEMENT_TITLE

    User.find_each(batch_size: BATCH_SIZE) do |user|
      Logic::SendSingleEmailJob.perform_later(user.id, subject, title, content)
    end
  end
end