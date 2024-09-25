describe 'show courses feature', type: :feature do
  before :each do
    @user = create(:user)
    @course = create(:course, author: @user)
    @lesson = create(:lesson, course: @course)
  end

  scenario 'Logging in with correct credentials' do
    visit new_user_session_path

    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password

    click_button 'Login'
    expect(page).to have_content 'Explore'
    expect(page).to have_content @user.username
  end

  scenario 'Logging in with invalid username' do
    visit new_user_session_path

    fill_in 'Username', with: 'user'
    fill_in 'Password', with: @user.password

    click_button 'Login'
    expect(page).to have_content 'Login failed'
  end
end
