Rails.application.routes.draw do
  devise_for :users
  resources :dishes do
    resources :reviews, except: [:show, :index]
  end
  root 'dishes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


#get "rate" => "dishes#rate"
