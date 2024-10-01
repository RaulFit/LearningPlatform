require 'rails_helper'

feature 'Courses page' do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, author: user) }

  background do
    log_in(user)
  end

  scenario 'Checking my courses page' do
    visit courses_path(authored: true)

    expect(page).to have_css('h1', text: course.title.to_s)
    expect(page).to have_css('a', text: 'Read more...')
    expect(page).to have_css('a', text: 'Add lesson')
    expect(page).to have_css('a', text: 'Edit')
  end
end
