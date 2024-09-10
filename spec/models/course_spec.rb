require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { create(:course) }

  describe 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:lessons).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:registrations).dependent(:destroy) }
    it { is_expected.to belong_to(:author) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_length_of(:title).is_at_least(3) }
    it { is_expected.to validate_length_of(:description).is_at_least(10) }
  end
end
