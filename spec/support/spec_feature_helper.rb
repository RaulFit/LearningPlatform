module SpecFeatureHelper
  def log_in(user)
    visit new_user_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Login'
    expect(page).to have_content 'Explore'
  end
end
