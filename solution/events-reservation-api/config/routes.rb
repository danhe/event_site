# frozen_string_literal: tru

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :events, only: %i[index create show]
      resources :sessions, only: %i[create destroy]
      resources :invitations, only: %i[create]

      resources :users, only: %i[update show], param: 'token'
      post '/register/:token', to: 'users#update'

      # Matches any undefined route to base#undefined_route to handle unknown routes
      get '*a', to: 'base#undefined_route'
    end
  end
end
