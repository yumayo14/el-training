# frozen_string_literal: true

# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  issue_id   :bigint
#
# Indexes
#
#  index_steps_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

FactoryBot.define do
  factory :step do
    issue
    title { 'ステップ' }
  end
end
