class Course < ApplicationRecord
  scope :enroled, ->(user_id) { where(id: Enrolment.where(user_id:).pluck(:course_id)) }
  scope :available, ->(user_id) { where.not(id: enroled(user_id)) }
  scope :authored, ->(user_id) { where(author_id: user_id) }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :course_lessons, dependent: :destroy
  has_many :lessons, -> { order(:position) }, through: :course_lessons
  has_many :enrolments, dependent: :destroy
  has_one_attached :photo
  has_rich_text :description
  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true

  def swap_lessons(first_lesson, second_lesson)
    first_pos = first_lesson.position
    second_pos = second_lesson.position
    first_lesson.set_position(second_pos)
    second_lesson.set_position(first_pos)
  end

  def get_course_lesson(lesson)
    course_lessons.find_by(lesson_id: lesson.id)
  end

  def tag_list
    tags.collect(&:name).join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name:) }
    self.tags = new_or_found_tags
  end
end
