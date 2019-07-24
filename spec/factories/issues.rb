# == Schema Information
#
# Table name: issues
#
#  id           :bigint           not null, primary key
#  dead_line_on :date             not null
#  status       :integer          default(0)
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_issues_on_status  (status)
#  index_issues_on_title   (title)
#

FactoryBot.define do
  factory :issue do
    title { Faker::Book.title }
    status { [0,1,2].sample }
    dead_line_on { '2019-08-30' }
  end
end
