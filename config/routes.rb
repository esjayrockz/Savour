Rails.application.routes.draw do
  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete

resources :users
  resources :dishes do
    collection do
      get 'search'
    end
    resources :reviews, except: [:show, :index]
  end
  root 'dishes#index'

get 'rate', to: 'dishes#rate'
get 'user_profile', to: 'dishes#user_profile'
get 'restaurant_profile', to: 'dishes#restaurant_profile'
get 'admin', to: 'dishes#admin'
#match 'users/:id' => 'users#destroy', :via => :delete

#resources :users, only: [:index, :show, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


#get "rate" => "dishes#rate"
