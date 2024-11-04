class Lesson < ApplicationRecord
  belongs_to :course
  has_many :comments, dependent: :destroy
  has_many :course_lessons, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }
  has_rich_text :content
  has_one_attached :photo
end
