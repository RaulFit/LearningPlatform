require 'rails_helper'

RSpec.describe Lesson, type: :model do
  subject { create(:lesson) }

  describe 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:course) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_length_of(:title).is_at_least(3) }
    it { is_expected.to validate_length_of(:body).is_at_least(20) }
  end
end
