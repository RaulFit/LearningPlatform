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
    expect(page).to have_css('h6', text: 'My learning', wait: 5)
  end
end
