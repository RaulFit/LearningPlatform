class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def update_progress(course, position)
    self.progress = (position.to_f / course.lessons.count * 100).to_i
    save
  end
end
