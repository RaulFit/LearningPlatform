class AddLessonIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :lesson, null: false, foreign_key: true
  end
end
