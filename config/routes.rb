Rails.application.routes.draw do

  resources :reports
  get 'home/index'
  root 'home#index'

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :signatures, only: [:new, :create] do
    collection do
      get :sign
    end
  end

  resources :reports, except: [:edit] do
    member do
      get :print
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
