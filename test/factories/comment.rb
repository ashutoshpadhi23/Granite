# frozen_string_literal: true

FactoryBot.define do
  factory :commment do
    user
    task
    content { Faker::Lorem.paragraph }
  end
end
