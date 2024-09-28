class Course < ApplicationRecord
  scope :current_user_is_enroled, ->(id) { where(id: Enrolment.where(user_id: id).pluck(:course_id)) }
  scope :available_to_enrol, ->(id) { where.not(author_id: id).where.not(id: current_user_is_enroled(id)) }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :enrolments, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
end
