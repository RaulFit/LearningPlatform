class AddPublicToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :public, :boolean
  end
end
