class AddDifficultyToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :difficulty, :string
  end
end
