class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  has_rich_text :content
end
