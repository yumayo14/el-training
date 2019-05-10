# frozen_string_literal: true

class Task < ApplicationRecord
  enum importance: { low: 0, middle: 1, high: 2 }
  enum status: { not_started: 0, working: 1, completed: 2 }

  validates :title, presence: true, length: { maximum: 30 }
  validates :importance, inclusion: { in: %w(low middle high) }
  validates :status, inclusion: { in: %w(not_started working completed) }
  validate :dead_line_on_cannot_be_in_the_past

  scope :orderd_by, ->(sort) { order(created_at: sort) }
  scope :by_title, ->(title) { where('title LIKE(?)', "%#{sanitize_sql_like(title)}%") }
  scope :by_status, ->(status) { where(status: status) }
  scope :search, ->(title, status) { by_title(title).by_status(status) }

  def dead_line_on_cannot_be_in_the_past
    errors.add(:dead_line_on, 'に過去の日付は使用できません') if dead_line_on.present? && dead_line_on < Date.today
  end
end
