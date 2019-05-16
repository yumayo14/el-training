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

  validates :name, presence: true, length: { maximum: 20 }
  validates :accountid, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
end
