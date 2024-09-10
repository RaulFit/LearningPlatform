class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :registrations, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
end
