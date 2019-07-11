  Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/static_pages/home", to: "static_pages#home"
    get "/static_pages/help", to: "static_pages#help"
    get "/static_pages/about", to: "static_pages#about"
    get "/static_pages/contact", to: "static_pages#contact"
    get "/users/signup", to: "users#new"
    post "users/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :sessions, only: %i(new create destroy)
  end
end
