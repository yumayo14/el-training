# frozen_string_literal: true

# == Schema Information
#
# Table name: issues
#
#  id           :bigint           not null, primary key
#  dead_line_on :date             not null
#  status       :integer          default("未着手")
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_issues_on_status   (status)
#  index_issues_on_title    (title)
#  index_issues_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Issue < ApplicationRecord
  has_many :steps
  belongs_to :user

  enum status: { 未着手: 0, 着手: 1, 完了: 2 }

  validates :title, presence: true
  validates :status, inclusion: { in: %w(未着手 着手 完了) }
  validate :dead_line_on_cannot_be_in_the_past
  after_create :create_associated_three_steps

  def dead_line_on_cannot_be_in_the_past
    errors.add(:dead_line_on, 'は今日以降の日付を入力してください') if dead_line_on.present? && dead_line_on < Time.zone.today
  end

  private

  def create_associated_three_steps
    Step.import [steps.new(title: 'ステップ'), steps.new(title: 'ステップ'), steps.new(title: 'ステップ')], validate: true
  end
end
