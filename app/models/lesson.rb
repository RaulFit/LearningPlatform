class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, presence: true, length: { minimum: 3 }
  has_rich_text :content

  def self.swap_lessons(first_lesson, second_lesson)
    first_pos = first_lesson.position
    second_pos = second_lesson.position
    first_lesson.position = second_pos
    first_lesson.save
    second_lesson.position = first_pos
    second_lesson.save
  end
end
