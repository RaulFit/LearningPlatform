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
          post enrolments_path,
               params: { enrolment: attributes_for(:enrolment, user_id: user.id, course_id: course.id) }
        end.to change(Enrolment, :count).by(1)
      end

      it 'should redirect to enroled courses page after creating course' do
        post enrolments_path,
             params: { enrolment: attributes_for(:enrolment, user_id: user.id, course_id: course.id) }
        expect(response).to redirect_to courses_path(enroled: true)
      end

      it 'should not create an enrolment with invalid attributes' do
        expect do
          post enrolments_path,
               params: { enrolment: attributes_for(:enrolment, user_id: user.id, course_id: nil) }
        end.to change(Enrolment, :count).by(0)
      end
    end

    context 'Delete /Enrolment' do
      it 'should destroy an enrolment' do
        enrolment
        expect { delete enrolment_path(enrolment) }.to change(Enrolment, :count).by(-1)
      end
    end
  end

  context 'user is not logged in' do
    context 'GET /new' do
      it 'should not have access to the new page' do
        expect { get new_enrolment_path }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'POST /Enrolment' do
      it 'should not be able to create an enrolment' do
        expect do
          post enrolments_path,
               params: { enrolment: attributes_for(:enrolment, user_id: user.id, course_id: course.id) }
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Delete /Enrolment' do
      it 'should not be able to delete an enrolment' do
        expect { delete enrolment_path(enrolment) }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
