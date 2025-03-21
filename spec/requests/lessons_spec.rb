require 'rails_helper'

RSpec.describe 'Lessons', type: :request do
  let(:user) { create(:user) }
  let(:course) { create(:course, author: user) }
  let(:lesson) { create(:lesson, course:) }
  let(:course_lesson) { create(:course_lesson, course:, lesson:) }

  context 'user is logged in' do
    before do
      login(user)
    end

    context 'GET /new' do
      it 'should render new page' do
        get new_course_lesson_path(course)
        expect(response).to render_template :new
      end
    end

    context 'Get /Edit' do
      it 'should render edit page' do
        get edit_course_lesson_path(course, lesson, course_lesson:)
        expect(response).to render_template :edit
      end
    end

    context 'POST /Course/Lesson' do
      it 'should create a lesson with valid attributes' do
        expect do
          post course_lessons_path(course), params: { lesson: attributes_for(:lesson, course_id: course.id) }
        end.to change(Lesson, :count).by(1)
      end

      it 'should redirect to courses page after creating lesson' do
        post course_lessons_path(course), params: { lesson: attributes_for(:lesson, course_id: course.id) }
        expect(response).to redirect_to courses_path(authored: true)
      end

      it 'should not create a lesson with invalid attributes' do
        expect do
          post course_lessons_path(course), params: { lesson: attributes_for(:lesson, title: nil) }
        end.to change(Lesson, :count).by(0)
      end
    end

    context 'Put /Course/Lesson' do
      it 'should update a lesson with valid attributes' do
        put course_lesson_path(course, lesson, course_lesson:),
            params: { lesson: attributes_for(:lesson, title: 'New title') }
        expect(flash[:notice]).to eq 'Lesson updated successfully'
        expect(Lesson.find(lesson.id).title).to eq 'New title'
      end

      it 'should redirect to the courses page if successfully updated' do
        put course_lesson_path(course, lesson, course_lesson:),
            params: { lesson: attributes_for(:lesson, title: 'New title') }
        expect(response).to redirect_to courses_path(authored: true)
      end

      it 'should not update a lesson with invalid attributes' do
        put course_lesson_path(course, lesson, course_lesson:),
            params: { lesson: attributes_for(:lesson, title: nil) }
        expect(response).to render_template :edit
        expect(flash[:alert]).to eq 'Lesson not updated'
      end
    end
  end

  context 'user is not logged in' do
    context 'GET /index' do
      it 'should not have access to the index page' do
        expect { get course_lessons_path(course) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'GET /show' do
      it 'should not have access to the show page' do
        expect { get course_lesson_path(course, lesson) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'GET /new' do
      it 'should not have access to the new page' do
        expect { get new_course_lesson_path(course) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Get /Edit' do
      it 'should not have access to the edit page' do
        expect { get edit_course_lesson_path(course, lesson) }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'POST /Course/Lesson' do
      it 'should not be able to create a lesson' do
        expect do
          post course_lessons_path(course), params: { lesson: attributes_for(:lesson, course_id: course.id) }
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Put /Course/Lesson' do
      it 'should not be able to edit a lesson' do
        expect do
          put course_lesson_path(course, lesson),
              params: { lesson: attributes_for(:lesson, title: 'New title') }
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'Delete /Course/Lesson' do
      it 'should not be able to delete a lesson' do
        expect { delete course_lesson_path(course, lesson) }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
