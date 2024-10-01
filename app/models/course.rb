class Course < ApplicationRecord
  scope :enroled, ->(user_id) { where(id: Enrolment.where(user_id:).pluck(:course_id)) }
  scope :available, ->(user_id) { where.not(id: enroled(user_id)) }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :enrolments, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
end
