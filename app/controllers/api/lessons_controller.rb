class Api::LessonsController < ApplicationController
  include CommonValidator

  before_action :ensure_user!
  before_action :ensure_course!

  def list
    @lessons = @course.lessons
  end

  def bulk_update
    records = build_records(lesson_data_params)

    ActiveRecord::Base.transaction do
      Lesson.import(records,
                    on_duplicate_key_update: %i[title context])
    end

    @total = records.size
  end

  def destroy
    lesson = @course.lessons.find(params[:id])

    lesson.destroy!
  end

  private

  def lesson_data_params
    params.require(:lessons).map do |lesson|
      lesson.permit(:id, :title, :context)
    end
  end

  def build_records(lesson_params)
    existing_lessons = @course.lessons.index_by(&:id)

    lesson_params.map do |attrs|
      if existing_lessons[attrs[:id]].present?
        existing_lessons[attrs[:id].to_i].tap do |lesson|
          lesson.assign_attributes(attrs.merge(AttributeUtils.update_hash))
        end
      else
        @course.lessons.new(attrs.merge(AttributeUtils.create_hash))
      end
    end
  end
end
