class PagesController < ApplicationController
  def index
    redirect_to courses_path(enroled: true) and return if current_user

    redirect_to pages_hero_path
  end

  def hero; end
end
