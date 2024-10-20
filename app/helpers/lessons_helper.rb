module LessonsHelper
  def move_lower
    CourseLesson.swap_lessons(@course.course_lessons.find_by(position: params[:position].to_i),
                              @course.course_lessons.find_by(position: params[:position].to_i - 1))
  end

  def move_higher
    CourseLesson.swap_lessons(@course.course_lessons.find_by(position: params[:position].to_i),
                              @course.course_lessons.find_by(position: params[:position].to_i + 1))
  end
end
