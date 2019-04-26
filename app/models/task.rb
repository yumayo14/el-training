# frozen_string_literal: true

class Task < ApplicationRecord
  enum importance: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手: 1, 完了: 2 }

  validates :title, presence: true, length: { maximum: 30 }
  validates :importance, inclusion: { in: %w(低 中 高) }
  validates :status, inclusion: { in: %w(未着手 着手 完了) }
  validate :dead_line_on_cannot_be_in_the_past

  scope :orderd_by, ->(sort) { order(created_at: sort) }
  scope :by_title, ->(title) { where('title LIKE(?)', "%#{sanitize_sql_like(title)}%") }
  scope :by_status, ->(status) { where(status: status) }
  scope :search, ->(title, status) { by_title(title).by_status(status) }

  def dead_line_on_cannot_be_in_the_past
    errors.add(:dead_line_on, 'に過去の日付は使用できません') if dead_line_on.present? && dead_line_on < Date.today
  end
end
