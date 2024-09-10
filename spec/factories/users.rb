# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 6, max_length: 20)
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
