require 'rails_helper'

feature 'Courses page' do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, author: user) }

  background do
    log_in(user)
  end

  scenario 'Checking my courses page' do
    visit courses_path(authored: true)
    expect(page).to have_css('h6', text: 'My courses', wait: 5)
    expect(page).to have_css('h1', text: course.title.to_s)
    expect(page).to have_css('h6', text: course.difficulty.to_s)
  end
end
