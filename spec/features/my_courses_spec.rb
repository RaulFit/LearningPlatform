require 'rails_helper'

feature 'Courses page' do
  background do
    @user = create(:user)
    @course = create(:course, author: @user)
  end

  scenario 'Checking my courses page' do
    visit new_user_session_path
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Login'

    visit courses_path(authored: true)
    expect(page).to have_css('h1', text: @course.title.to_s)
    expect(page).to have_css('a', text: 'Read more...')
    expect(page).to have_css('a', text: 'Add lesson')
    expect(page).to have_css('a', text: 'Edit')
  end
end
