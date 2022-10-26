# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.paragraph }
    user { User.find(Faker::Number.rand_in_range(1, User.all.count)) }
    student { Student.find(Faker::Number.rand_in_range(1, Student.all.count)) }
    comment { Comment.find(Faker::Number.rand_in_range(1, Comment.all.count)) }
  end
end
