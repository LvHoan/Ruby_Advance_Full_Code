# frozen_string_literal: true

module CommonValidator

  def ensure_user!

    user_id = params[:user_id] || params[:id]
    raise ActiveRecord::RecordNotFound, I18n.t("message.not_found.course") unless user_id

    @user = User.find(user_id)
  end

  def ensure_course!
    @course = Course.find_by(id: params[:course_id])
    raise ActiveRecord::RecordNotFound, I18n.t("message.not_found.default") if @course.blank?
  end

end
