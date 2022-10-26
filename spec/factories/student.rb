# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.birthday }
    address { Faker::Address.street_address }
    scholarity { Student.scholarities.keys.sample }
    goes_to_school { true }
    user { User.find(Faker::Number.rand_in_range(1, User.all.count)) }
  end
end
