# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    highlight { false }
    img_src { '' }
    user { User.find(Faker::Number.rand_in_range(1, User.all.count)) }
    student { Student.find(Faker::Number.rand_in_range(1, Student.all.count)) }
  end
end
