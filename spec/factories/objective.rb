# frozen_string_literal: true

FactoryBot.define do
  factory :objective do
    content { Faker::Lorem.sentence }
    done { true }
    user { User.find(Faker::Number.rand_in_range(1, User.all.count)) }
    student { Student.find(Faker::Number.rand_in_range(1, Student.all.count)) }
  end
end
