require 'rails_helper'

RSpec.describe 'Enrolments', type: :request do
  let(:user) { create(:user) }
  let(:course) { create(:course, author: user) }
  let(:enrolment) { create(:enrolment, user:, course:) }

  context 'user is logged in' do
    before do
      login(user)
    end

    context 'POST /Enrolment' do
      it 'should create an enrolment with valid attributes' do
        expect do
          post course_enrolments_path(course),
               params: { enrolment: attributes_for(:enrolment, user_id: user.id, progress: 0) }
        end.to change(Enrolment, :count).by(1)
      end

      it 'should redirect to enroled courses page after creating course' do
        post course_enrolments_path(course),
             params: { enrolment: attributes_for(:enrolment, user_id: user.id, progress: 0) }

        expect(response).to redirect_to courses_path(enroled: true)
      end

      it 'should not create an enrolment with invalid attributes' do
        expect do
          post course_enrolments_path(course),
               params: { enrolment: attributes_for(:enrolment, user_id: nil, progress: 0) }
        end.to change(Enrolment, :count).by(0)
      end
    end

    context 'Delete /Enrolment' do
      it 'should destroy an enrolment' do
        enrolment
        expect { delete course_enrolment_path(course, enrolment) }.to change(Enrolment, :count).by(-1)
      end
    end
  end

  context 'user is not logged in' do
    context 'GET /new' do
      it 'should not have access to the new page' do
        expect { get new_course_enrolment_path(course) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'POST /Enrolment' do
      it 'should not be able to create an enrolment' do
        expect do
          post course_enrolments_path(course),
               params: { enrolment: attributes_for(:enrolment, user_id: user.id, course_id: course.id, progress: 0) }
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Delete /Enrolment' do
      it 'should not be able to delete an enrolment' do
        expect { delete course_enrolment_path(course, enrolment) }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
