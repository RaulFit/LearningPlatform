class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def update_progress(position)
    self.progress = position
    save
  end
end
