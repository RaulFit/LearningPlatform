require 'rails_helper'

feature 'My learning' do
  let!(:first_user) { create(:user) }
  let!(:second_user) { create(:user) }
  let!(:course) { create(:course, author: first_user) }
  let!(:enrolment) { create(:enrolment, user: second_user, course:) }

  background do
    log_in(second_user)
  end

  scenario 'Checking my learning page' do
    visit courses_path(enroled: true)

    expect(page).to have_css('h1', text: course.title.to_s)
    expect(page).to have_css('a', text: 'Resume')
    expect(page).to have_selector 'div#progressBar'
  end
end
