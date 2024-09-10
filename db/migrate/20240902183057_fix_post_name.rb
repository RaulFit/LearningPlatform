class FixPostName < ActiveRecord::Migration[7.1]
  def self.up
    rename_column :comments, :post_id, :course_id
  end

  def self.down
    rename_column :comments, :course_id, :post_id
  end
end
