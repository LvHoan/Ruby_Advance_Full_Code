# frozen_string_literal: true

class CourseExporter
  require 'csv'

  def initialize(user)
    @user = user
  end

  def to_csv
    courses = @user.courses

    CSV.generate(headers: true) do |csv|
      csv << %w[id title description image_url created_at updated_at]

      courses.find_each do |course|
        csv << [
          course.id,
          course.title,
          course.description,
          course.image_url,
          course.created_at,
          course.updated_at
        ]
      end
    end
  end
end

