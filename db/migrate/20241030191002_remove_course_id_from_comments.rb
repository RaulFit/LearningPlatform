class RemoveCourseIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :course_id
  end
end
