module SpecFeatureHelper
  def log_in(user)
    page.driver.browser.manage.window.resize_to(1920, 1080)
    visit new_user_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Login'
  end
end
