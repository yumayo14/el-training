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

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_save :set_hashed_password

  validates :name, presence: true, length: { maximum: 20 }
  validates :accountid, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :hashed_password, presence: true, length: { minimum: 8 }
  validates :salt, presence: true, uniqueness: true, on: :update

  def authenticate?(login_password)
    return true if hashed_password == hash_password(salt, login_password)

    false
  end

  private

  def hash_password(salt, plain_password)
    Digest::SHA256.hexdigest(salt + plain_password)
  end

  def set_hashed_password
    self.hashed_password = hash_password(set_salt, hashed_password)
  end

  def set_salt
    self.salt ||= SecureRandom.hex(8)
  end
end
