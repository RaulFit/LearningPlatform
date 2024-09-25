describe 'Signing up', type: :feature do
  scenario 'Signing in with invalid credentials' do
    visit new_user_path

    fill_in 'Username', with: 'Johnny'
    fill_in 'Email', with: 'alex.smith@gmail.com'
    fill_in 'Password', with: 't'
    fill_in 'Password confirmation', with: 't'

    click_button 'Sign up'
    expect(page).to have_content 'User not created'
    expect(page).to have_content 'Password is too short (minimum is 3 characters)'
    expect(page).to have_content 'Create a new account'
  end
end
