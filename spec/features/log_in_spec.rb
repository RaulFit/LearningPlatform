require 'rails_helper'

feature 'Log in' do
  background do
    @user = create(:user)
  end

  scenario 'Logging in with correct credentials' do
    visit new_user_session_path

    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password

    click_button 'Login'
    expect(page).to have_content 'Explore'
    expect(page).to have_content @user.username.to_s
  end

  scenario 'Logging in with invalid username' do
    visit new_user_session_path

    fill_in 'Username', with: 'user'
    fill_in 'Password', with: @user.password

    click_button 'Login'
    expect(page).to have_content 'Login failed'
    expect(page).to have_css('h1', text: 'Log in to your account')
  end
end
