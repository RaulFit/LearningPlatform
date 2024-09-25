class RenameRegistrationsToEnrolments < ActiveRecord::Migration[7.1]
  def change
    rename_table :registrations, :enrolments
  end
end
