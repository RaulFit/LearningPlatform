class RenameUserIdToAuthorId < ActiveRecord::Migration[7.1]
  def self.up
    rename_column :courses, :user_id, :author_id
  end

  def self.down
    rename_column :courses, :author_id, :user_id
  end
end
