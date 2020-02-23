# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :reports

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
