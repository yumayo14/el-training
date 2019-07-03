# frozen_string_literal: true

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        tasks#index
#                     tasks GET    /tasks(.:format)                                                                         tasks#index
#                  new_task GET    /tasks/new(.:format)                                                                     tasks#new
#                 edit_task GET    /tasks/:id/edit(.:format)                                                                tasks#edit
#                      task GET    /tasks/:id(.:format)                                                                     tasks#show
#                           PATCH  /tasks/:id(.:format)                                                                     tasks#update
#                           PUT    /tasks/:id(.:format)                                                                     tasks#update
#                     login GET    /login(.:format)                                                                         sessions#new
#                           POST   /login(.:format)                                                                         sessions#create
#                    logout DELETE /logout(.:format)                                                                        sessions#destroy
#                 api_tasks GET    /api/tasks(.:format)                                                                     api/tasks#index {:format=>/json/}
#                           POST   /api/tasks(.:format)                                                                     api/tasks#create {:format=>/json/}
#                  api_task PATCH  /api/tasks/:id(.:format)                                                                 api/tasks#update {:format=>/json/}
#                           PUT    /api/tasks/:id(.:format)                                                                 api/tasks#update {:format=>/json/}
#                           DELETE /api/tasks/:id(.:format)                                                                 api/tasks#destroy {:format=>/json/}
#     api_open_weather_maps GET    /api/open_weather_maps(.:format)                                                         api/open_weather_maps#current_tokyo_weather {:format=>/json/}
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'tasks#index'
  resources :tasks, except: %i(create destroy)

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  namespace :api, format: 'json' do
    resources :tasks, only: %i(index create update destroy)
    get 'open_weather_maps', to: 'open_weather_maps#current_tokyo_weather'
  end
end
