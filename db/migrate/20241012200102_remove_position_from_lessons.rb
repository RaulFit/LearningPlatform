class RemovePositionFromLessons < ActiveRecord::Migration[7.1]
  def change
    remove_column :lessons, :position, :integer
  end
end
