# require 'faker'
#
# FactoryBot.define do
#   factory :task do
#     title { Faker::Pokemon.location }
#     importance { [0,1,2].sample }
#     dead_line_on { Faker::Date.between(Date.today, 1.year.from_now) }
#     status{ [0,1,2].sample }
#     detail { Faker::Job.title }
#   end
# end

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "#{n}番目" }
    importance { 0 }
    sequence(:dead_line_on) { |n| "2020-07-#{n}"}
    status { 0 }
    detail { "infinity_task..." }
  end
end


