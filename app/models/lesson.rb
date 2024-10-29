class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, presence: true, length: { minimum: 3 }
  has_rich_text :content
  has_one_attached :photo
end
