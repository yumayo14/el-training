# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  accountid           :string(255)      default("0"), not null
#  hashed_cookie_token :string(255)
#  hashed_password     :string(255)      not null
#  name                :string(255)      not null
#  salt                :string(255)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    accountid { Faker::Internet.unique.username(1..15) }
    password { Faker::Internet.password }
    hashed_password {}
    hashed_cookie_token {}
    salt {}
  end
end
