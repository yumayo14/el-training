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
  belongs_to :user

  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
end
