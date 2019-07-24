# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                                                                                   :bigint           not null, primary key
#  accountid(ユーザーのアカウントID、ユーザー固有の値)                                  :string(255)      default("0"), not null
#  hashed_cookie_token(ユーザーのログイン時に使用されるcookiesトークンを暗号化したもの) :string(255)
#  hashed_password(ハッシュ化されたユーザーのパスワード)                                :string(255)      not null
#  name(ユーザーの本名)                                                                 :string(255)      not null
#  salt(パスワードハッシュ化の際に用いるデータ)                                         :string(255)      not null
#  created_at                                                                           :datetime         not null
#  updated_at                                                                           :datetime         not null
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
