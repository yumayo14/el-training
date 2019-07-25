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
#
# Indexes
#
#  index_issues_on_status  (status)
#  index_issues_on_title   (title)
#

require 'rails_helper'

RSpec.describe Issue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
