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
#  fk_rails_720ad5f20e  (issue_id => issues.id) ON DELETE => cascade
#

class Step < ApplicationRecord
  belongs_to :issue

  validates :title, presence: true
end
