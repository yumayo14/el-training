FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    accountid { Faker::Internet.unique.username(1..15) }
    password { Faker::Internet.password }
  end
end
