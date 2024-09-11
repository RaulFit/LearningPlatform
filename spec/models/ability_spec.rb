require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }
  let(:user) { create(:user) }
  let(:course) { create(:course, author: user) }
  let(:comment) { create(:comment, user:, course:) }
  let(:registration) { create(:registration, user:, course:) }

  describe 'User' do
    describe 'abilities' do
      it { is_expected.to be_able_to(:manage, course) }
      it { is_expected.to be_able_to(:manage, comment) }
    end
  end
end
