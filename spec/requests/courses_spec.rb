require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  let(:user) { create(:user) }
  let(:course) { create(:course, author: user) }

  before do
    ApplicationController.any_instance.stub(:current_user).and_return(@user = user)
  end

  context 'GET /index' do
    it 'should render index page' do
      get courses_path
      expect(response).to render_template :index
    end
  end

  context 'GET /show' do
    it 'should render show page' do
      get course_path(course)
      expect(response).to render_template :show
    end
  end

  context 'GET /new' do
    it 'should render new page' do
      get new_course_path
      expect(response).to render_template :new
    end
  end

  context 'Get /Edit' do
    it 'should render edit page' do
      get edit_course_path(course)
      expect(response).to render_template :edit
    end
  end

  context 'POST /Course' do
    it 'should create a course with valid attributes' do
      post '/courses', params: { course: attributes_for(:course) }
      expect(response).to redirect_to user_path(user)
      expect(flash[:notice]).to eq 'Course created successfully'
    end

    it 'should not create a course with invalid attributes' do
      post '/courses', params: { course: attributes_for(:course, title: nil) }
      expect(response).to render_template :new
      expect(flash[:alert]).to eq 'Course not created'
    end
  end

  context 'Put /Course' do
    it 'should update a course with valid attributes' do
      put "/courses/#{course.id}", params: { course: attributes_for(:course) }
      expect(response).to redirect_to courses_mycourses_path(user)
      expect(flash[:notice]).to eq 'Course updated successfully'
    end

    it 'should not update a course with invalid attributes' do
      put "/courses/#{course.id}", params: { course: attributes_for(:course, title: nil) }
      expect(response).to render_template :edit
      expect(flash[:alert]).to eq 'Course not updated'
    end
  end

  context 'Delete /Course' do
    it 'should destroy a course' do
      delete "/courses/#{course.id}"
      expect(response).to redirect_to courses_mycourses_path(user)
      expect(flash[:notice]).to eq 'Course deleted successfully'
    end
  end
end
