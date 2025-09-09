# frozen_string_literal: true
class NotificationMailer < ApplicationMailer
  # Thông báo đăng ký khóa học
  # subject: default dùng I18n
  def course_registration_success(user, course)
    @user = user
    @course = course
    subject = EmailConstants::COURSE_REGISTER_SUCCESS
    mail(to: @user.email, subject: subject)
  end

  # Thông báo chung
  # announcement_data: { title: "Tiêu đề", content: "Nội dung" }
  def general_announcement(user, subject, announcement_data)
    @user = user
    @body = announcement_data
    mail(to: @user.email, subject: subject)
  end
end
