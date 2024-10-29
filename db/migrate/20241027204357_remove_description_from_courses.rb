class RemoveDescriptionFromCourses < ActiveRecord::Migration[7.1]
  def change
    remove_column :courses, :description, :text
  end
end
