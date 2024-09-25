# frozen_string_literal: true

FactoryBot.define do
  factory :enrolment do
    association :user
    association :course
  end
end
