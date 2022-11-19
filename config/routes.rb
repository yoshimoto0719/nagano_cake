Rails.application.routes.draw do



# 管理者用(admin)
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
end



# 顧客用(public)
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

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

  resources :orders, except:[:edit, :update, :destroy]
  post '/orders/confirm' => 'orders#confirm'
  get '/orders/complete' => 'orders#complete'

  resources :addresses, except:[:new, :show]
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
