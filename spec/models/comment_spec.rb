require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { create(:comment) }

  describe 'columns' do
    it { is_expected.to have_db_column(:body).of_type(:text) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(1) }
  end
end
