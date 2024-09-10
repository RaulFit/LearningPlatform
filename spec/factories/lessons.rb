# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { Faker::Educator.course_name }
    body { Faker::Lorem.paragraphs(number: 3).join("\n") }
    association :course
  end
end
