# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  accountid  :string(255)      default("0"), not null
#  password   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    accountid { Faker::Internet.unique.username(1..15) }
    hashed_password { Faker::Internet.password }
    salt {}
    hashed_cookie_token {}
  end
end
