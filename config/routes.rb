Rails.application.routes.draw do

# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用(admin)
namespace :admin do
  get root to: 'homes#top'

  resources :items, except:[:destroy]

  resources :genres, except:[:new, :show, :destroy]

  resources :customers, except:[:new, :create, :destroy]

  resources :orders, only:[:show, :update]
  get '/admin/orders/:id' => 'orders#show'

  resources :order_details, only:[:update]
end



# 顧客用(public)
scope module: :public do
  root to: 'homes#top'
  get "/homes/about" => "homes#about"

  resources :items, except: [:destroy]

  get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
  get "customers/my_page" => "customers#show"
  get '/customers/information/edit' => 'customers#edit'
  put 'customer/update' => 'customers#update'
  patch '/customers/information' => 'customers#update'

  resources :cart_items, except:[:show, :new, :edit]
  delete '/cart_items/destroy_all' => 'cart_items#destroy_all'

  get '/orders/complete' => 'orders#complete'
  resources :orders, except:[:edit, :update, :destroy]
  post '/orders/confirm' => 'orders#confirm'

  resources :addresses, except:[:show]
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
