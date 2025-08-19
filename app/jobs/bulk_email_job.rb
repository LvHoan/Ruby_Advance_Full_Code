class BulkEmailJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 100

  def perform(subject, content)
    users = User.all
    title = EmailConstants::BULK_ANNOUNCEMENT_TITLE

    # Lấy theo batch 100 user
    users.find_in_batches(batch_size: BATCH_SIZE) do |batch|
      batch.each do |user|
        # enqueue riêng cho từng email, retry riêng từng user
        Logic::SendSingleEmailJob.perform_later(user.id, subject, title, content)
      end
    end
  end
end