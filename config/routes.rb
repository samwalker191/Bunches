Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, except: [:new, :edit] do 
    resources :bunches, only: [:index, :create]
  end
  resources :bunches, except: [:new, :edit, :index, :create]
end
