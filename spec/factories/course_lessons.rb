FactoryBot.define do
  factory :course_lesson do
    association :course
    association :lesson
    position { 0 }
  end
end
