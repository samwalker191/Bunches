Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do 
    resources :bunches, only: [:index, :create]
  end

  resources :bunches, except: [:new, :index]
  resource :session, only: [:new, :create, :destroy]

  get '*unmatched_route', to: 'application#raise_not_found'
end
