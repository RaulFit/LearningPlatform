require 'rails_helper'

RSpec.describe Enrolment, type: :model do
  subject { create(:enrolment) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course) }
  end
end
