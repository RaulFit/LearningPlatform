require 'rails_helper'

RSpec.describe Registration, type: :model do
  subject { create(:registration) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course) }
  end
end
