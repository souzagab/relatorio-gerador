# frozen_string_literal: true

Rails.application.routes.draw do

  root 'home#index'
  get 'home/index'

  resources :reports do
    member do
      get 'export'
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
