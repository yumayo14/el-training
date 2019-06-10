# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  user_id      :bigint
#  title        :string(255)      not null
#  importance   :integer          default("low")
#  dead_line_on :date
#  status       :integer          default("not_started")
#  detail       :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :task do
    user
    sequence(:title) { |n| "#{n}番目" }
    importance { 0 }
    sequence(:dead_line_on) { |n| "2020-07-#{n}" }
    status { 0 }
    detail { 'infinity_task...' }
  end
end
