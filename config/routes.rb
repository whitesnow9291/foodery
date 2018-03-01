Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations', passwords: 'passwords', omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    get 'restaurateurs/new' => 'registrations#new_restaurateur'
    post 'restaurateurs/sign_up' => 'registrations#create_restaurateur'
  end

  resources :restaurants, only: [:show, :index]

  resources :restaurateurs do
    get :sign_in, on: :collection
    get :remove_stripe_connect, on: :collection
    get :fetch_restaurant, on: :collection
    get :order_details, on: :member
    post :restaurant_create, on: :collection
    get :order_confirm, on: :member
  end

  namespace :restaurateur do
    resources :restaurants, only: [:index, :create] do
      get :toggle, on: :member
    end
  end

  resources :users, only: [] do
    post :set_location, on: :collection
  end

  resources :orders, only: [:show, :index] do
    post :add_item, on: :member
    post :remove_item, on: :member
    post :process_order, on: :collection
    post :remove_active_order, on: :collection
    get :checkout, on: :collection
    get :success, on: :collection
    get :upcoming, on: :collection
    get :past, on: :collection
  end

  resource :webhook_events, only: :create

  root 'home#home', as: 'home'
  # get '/coming_soon', to: 'home#coming_soon', as: 'coming_soon'
  post 'receiver', to: 'home#receiver'
  # root 'home#coming_soon'
end
