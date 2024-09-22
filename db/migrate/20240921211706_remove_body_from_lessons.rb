class RemoveBodyFromLessons < ActiveRecord::Migration[7.1]
  def change
    remove_column :lessons, :body, :text
  end
end
