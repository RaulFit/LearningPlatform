require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  let(:user) { create(:user) }
  let(:course) { create(:course, author: user) }

  context 'user is logged in' do
    before do
      login(user)
    end

    context 'GET /index' do
      it 'should render index page' do
        get courses_path
        expect(response).to render_template :index
      end

      it 'is not a new course' do
        get courses_path
        expect(response.body).to match(have_tag_with_content('title', 'LearningPlatform'))
      end

      it 'should contain the course title' do
        course
        get courses_path
        expect(response.body).to include(course.title)
      end

      it 'should contain the course description' do
        course
        get courses_path
        expect(response.body).to include(course.description)
      end
    end

    context 'GET /show' do
      it 'should render show page' do
        get course_path(course)
        expect(response).to render_template :show
      end

      it 'should contain the course title' do
        course
        get courses_path
        expect(response.body).to include(course.title)
      end

      it 'should contain the course description' do
        course
        get courses_path
        expect(response.body).to include(course.description)
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
        expect do
          post courses_path, params: { course: attributes_for(:course, author_id: user.id) }
        end.to change(Course, :count).by(1)
      end

      it 'should redirect to courses page after creating course' do
        post '/courses', params: { course: attributes_for(:course, author_id: user.id) }
        expect(response).to redirect_to user_courses_mycourses_path(user)
      end

      it 'should not create a course with invalid attributes' do
        expect do
          post '/courses', params: { course: attributes_for(:course, title: nil) }
        end.to change(Course, :count).by(0)
      end
    end

    context 'Put /Course' do
      it 'should update a course with valid attributes' do
        put "/courses/#{course.id}", params: { course: attributes_for(:course, title: 'New title') }
        expect(flash[:notice]).to eq 'Course updated successfully'
        expect(Course.find(course.id).title).to eq 'New title'
      end

      it 'should redirect to the courses page if successfully updated' do
        put "/courses/#{course.id}", params: { course: attributes_for(:course) }
        expect(response).to redirect_to user_courses_mycourses_path(user)
      end

      it 'should not update a course with invalid attributes' do
        put "/courses/#{course.id}", params: { course: attributes_for(:course, title: nil) }
        expect(response).to render_template :edit
        expect(flash[:alert]).to eq 'Course not updated'
      end
    end

    context 'Delete /Course' do
      it 'should destroy a course' do
        course
        expect { delete "/courses/#{course.id}" }.to change(Course, :count).by(-1)
      end

      it 'should redirect to the courses page' do
        delete "/courses/#{course.id}"
        expect(response).to redirect_to user_courses_mycourses_path(user)
      end
    end
  end

  context 'user is not logged in' do
    context 'GET /index' do
      it 'should not have access to the index page' do
        expect { get courses_path }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'GET /show' do
      it 'should not have access to the show page' do
        expect { get course_path(course) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'GET /new' do
      it 'should not have access to the new page' do
        expect { get new_course_path }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Get /Edit' do
      it 'should not have access to the edit page' do
        expect { get edit_course_path(course) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'POST /Course' do
      it 'should not be able to create a course' do
        expect do
          post '/courses', params: { course: attributes_for(:course, author_id: user.id) }
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Put /Course' do
      it 'should not be able to edit a course' do
        expect do
          put "/courses/#{course.id}",
              params: { course: attributes_for(:course, title: 'New title') }
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Delete /Course' do
      it 'should not be able to delete a course' do
        expect { delete "/courses/#{course.id}" }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
