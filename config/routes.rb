# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  use_doorkeeper
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :clubs

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
