class CommentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :lesson, through: :course
  load_and_authorize_resource :comment, through: :lesson

  def create
    if @comment.save
      flash[:notice] = t(:comment_notice)
    else
      flash[:alert] = t(:comment_alert)
    end
    redirect_to course_lesson_path(@course, @lesson)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :lesson_id)
  end
end
