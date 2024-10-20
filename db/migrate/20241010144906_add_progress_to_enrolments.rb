class AddProgressToEnrolments < ActiveRecord::Migration[7.1]
  def change
    add_column :enrolments, :progress, :integer
  end
end
