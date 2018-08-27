FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "#{n}番目" }
    importance 0
    sequence(:dead_line_on) { |n| "2020-07-#{n}"}
    status 0
    detail "infinity_task..."
    
  end
end