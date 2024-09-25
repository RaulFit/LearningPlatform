require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'columns' do
    it { is_expected.to have_db_column(:username).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }
    it { is_expected.to have_db_column(:password_confirmation).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:authored_courses).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:enrolments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_presence_of :password_confirmation }
    it { is_expected.to validate_length_of(:username).is_at_least(1) }
    it { is_expected.to validate_length_of(:email).is_at_least(3) }
    it { is_expected.to validate_length_of(:password).is_at_least(3) }
  end
end
