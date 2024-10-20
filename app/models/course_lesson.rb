class CourseLesson < ApplicationRecord
  belongs_to :course
  belongs_to :lesson

  def set_position(position)
    self.position = position
    save
  end
end
