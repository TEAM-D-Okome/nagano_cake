Rails.application.routes.draw do

  # 顧客用ルーティング
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    get '/' => "homes#top", as: "root"
    get 'about' => 'homes#about'

    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdrawal'
      end
    end

    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :orders, only: [:new, :index, :show, :create] do
      post :confirm, on: :collection
      get :complete, on: :collection
    end

    resources :delivery_addresses, only: [:index, :create, :edit, :update, :destroy]

    get 'search' => 'searches#search'

  end



  # 管理者用ルーティング
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    #homes
    root to: "homes#top"
    #items
    resources :items,only: [:new,:index,:edit,:show,:update,:create]
    #genres
    resources :genres, only: [:index, :create, :edit, :update]
    #customers
    resources :customers, only: [:index, :show, :edit, :update]
    #orders
    resources :orders, only: [:show, :update, :index]
    #order_items
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
