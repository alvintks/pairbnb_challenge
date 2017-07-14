Rails.application.routes.draw do
  root 'sessions#new'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit] do
    resources :listings, controller: "listings" do 
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    end
  end

  resources :listings, controller: "listings" do 
    resources :reservations, controller: "reservations"
  end 
  
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/welcome" => "welcome#index", as: "welcome"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/new_payment" => "payment#new", as: "new_payment"
  post '/checkout' => "payment#checkout", as: "checkout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
