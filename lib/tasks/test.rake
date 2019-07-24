# frozen_string_literal: true

namespace :test do
  desc 'rubocopとrspecを同時に走らせるタスク'
  task :strict_mode do
    sh 'npm run lint_all_managed_by_webpacker --silent'
    sh 'bundle exec rubocop'
    sh 'bundle exec rspec'
    sh 'bundle exec annotate --exclude fixtures'
  end
end
