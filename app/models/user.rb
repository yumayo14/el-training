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

class User < ApplicationRecord
  attr_accessor :password, :cookie_token
  has_many :tasks, dependent: :destroy
  has_many :issues, dependent: :destroy

  before_save :set_hashed_password

  validates :name, presence: true, length: { maximum: 20 }
  validates :accountid, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :password_change
  validates :hashed_password, presence: true, on: :update
  validates :salt, presence: true, uniqueness: true, on: :update

  def authenticated?(login_password)
    return true if hashed_password == hashing_with_salt(salt, login_password)

    false
  end

  def make_cookie_token!
    self.cookie_token = new_cookie_token
    update_attributes(hashed_cookie_token: hashing_with_salt(salt, cookie_token))
  end

  def delete_cookie_token!
    self.cookie_token = nil
    update_attributes(hashed_cookie_token: nil)
  end

  private

  def hashing_with_salt(salt, plain_text)
    Digest::SHA256.hexdigest(salt + plain_text)
  end

  def new_cookie_token
    SecureRandom.urlsafe_base64
  end

  def set_hashed_password
    return hashed_password if password.nil?

    self.hashed_password = hashing_with_salt(set_salt, password)
  end

  def set_salt
    self.salt ||= SecureRandom.hex(8)
  end
end
