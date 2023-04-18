Rails.application.routes.draw do
  # 管理者用ルーティング
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # 顧客用ルーティング
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
    get '/' => "homes#top"
    get 'about' => 'homes#about'

    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    patch 'customers/withdrawal' => 'customers#withdrawal'
    get 'customers/unsubscribe' => 'customers#unsubscribe'

    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'

    resources :orders, only: [:new, :index, :show, :create]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/finish' => 'orders#finish'

    resources :delivery_addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update, :index]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
