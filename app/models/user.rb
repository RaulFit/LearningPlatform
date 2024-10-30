class User < ApplicationRecord
  has_secure_password

  has_many :authored_courses, class_name: 'Course', foreign_key: 'author_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :enrolments, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 1 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  def enroled?(course)
    enrolments.pluck(:course_id).include?(course.id)
  end

  def get_enrolment(course)
    enrolments.find_by(course_id: course.id)
  end

  def author?(course)
    id == course.author_id
  end
end
