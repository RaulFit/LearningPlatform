require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  context 'GET /index' do
    it 'should render index page' do
      get users_path
      expect(response).to render_template :index
    end
  end

  context 'GET /new' do
    it 'should render new page' do
      get new_user_path
      expect(response).to render_template :new
    end
  end

  context 'POST /User' do
    it 'should create a user with valid attributes' do
      post '/users', params: { user: attributes_for(:user) }
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to eq 'User created successfully'
    end

    it 'should not create a user with invalid attributes' do
      post '/users', params: { user: attributes_for(:user, username: nil) }
      expect(response).to render_template :new
      expect(flash[:alert]).to eq 'User not created'
    end
  end
end
