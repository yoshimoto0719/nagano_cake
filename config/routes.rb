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
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
