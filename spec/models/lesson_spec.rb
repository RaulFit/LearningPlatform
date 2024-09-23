require 'rails_helper'

RSpec.describe Lesson, type: :model do
  subject { create(:lesson) }

  describe 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:course) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_length_of(:title).is_at_least(3) }
  end
end
