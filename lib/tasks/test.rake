# frozen_string_literal: true

namespace :test do
  desc 'rubocopとrspecを同時に走らせるタスク'
  task :strict_mode do
    sh 'bundle exec rubocop'
    sh 'bundle exec rspec'
  end
end
