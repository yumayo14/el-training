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

class Task < ApplicationRecord
  belongs_to :user

  enum importance: { low: 0, middle: 1, high: 2 }
  enum status: { not_started: 0, working: 1, completed: 2 }

  validates :title, presence: true, length: { maximum: 30 }
  validates :importance, inclusion: { in: %w(low middle high) }
  validates :status, inclusion: { in: %w(not_started working completed) }
  validate :dead_line_on_cannot_be_in_the_past

  scope :orderd_by, ->(sort) { order(created_at: sort) }
  scope :by_title, ->(title) { where('title LIKE(?)', "%#{sanitize_sql_like(title)}%") }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :search, ->(title, status) { by_title(title).by_status(status) }

  def self.human_attribute_enum_value(attr_name, value)
    human_attribute_name("#{attr_name}.#{value}")
  end

  def human_attribute_enum(attr_name)
    self.class.human_attribute_enum_value(attr_name, self[attr_name])
  end

  def dead_line_on_cannot_be_in_the_past
    errors.add(:dead_line_on, 'に過去の日付は使用できません') if dead_line_on.present? && dead_line_on < Date.today
  end
end
