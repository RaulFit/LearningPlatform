class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 20 }
end
