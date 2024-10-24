# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    public { true }
    difficulty { 'Easy' }
    association :author, factory: :user
  end
end
