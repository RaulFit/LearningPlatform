require 'rails_helper'

feature 'Explore' do
  let!(:first_user) { create(:user) }
  let!(:second_user) { create(:user) }
  let!(:course) { create(:course, author: first_user) }

  background do
    log_in(second_user)
  end

  scenario 'Checking explore page' do
    visit courses_path(available: true)
    expect(page).to have_css('h1', text: course.title.to_s)
    expect(page).to have_css('a', text: 'Read more...')
    expect(page).to have_css('a', text: 'Enrol')
  end
end
