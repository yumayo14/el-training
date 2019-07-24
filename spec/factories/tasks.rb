# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id                                                                                                                              :bigint           not null, primary key
#  dead_line_on(タスクの期限)                                                                                                      :date
#  detail(タスクの詳細)                                                                                                            :text(65535)
#  importance(タスクの優先度)                                                                                                      :integer          default("low")
#  status(タスクの進捗)                                                                                                            :integer          default("not_started")
#  title(タスク名)                                                                                                                 :string(255)      not null
#  created_at                                                                                                                      :datetime         not null
#  updated_at                                                                                                                      :datetime         not null
#  user_id(タスクを投稿したユーザーのidと紐づけられる。投稿したユーザーが削除された場合、そのユーザーが投稿したタスクも削除される) :bigint
#
# Indexes
#
#  index_tasks_on_status   (status)
#  index_tasks_on_title    (title)
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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
