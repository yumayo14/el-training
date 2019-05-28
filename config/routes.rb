# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tasks
  root to: 'tasks#index'

  resources :sessions, only: %i(new create destroy)

  namespace :api do
    resources :tasks, only: [:index]
  end
end
