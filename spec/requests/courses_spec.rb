require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  let(:course) { create(:course) }

  context 'GET /index' do
    it 'should render index page' do
      get courses_path
      expect(response).to render_template :index
    end
  end
end
