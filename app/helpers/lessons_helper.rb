module LessonsHelper
  def move_lower
    Lesson.swap_lessons(@lessons.find_by(position: params[:position].to_i),
                        @lessons.find_by(position: params[:position].to_i - 1))
  end

  def move_higher
    Lesson.swap_lessons(@lessons.find_by(position: params[:position].to_i),
                        @lessons.find_by(position: params[:position].to_i + 1))
  end
end
