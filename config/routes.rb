Rails.application.routes.draw do

  
 root to: 'projects#index'
 
 get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

    
 get 'signup', to: 'users#new'
 resources :users, only: [:index, :show, :create] do
   member do
      get :completes
      get :incompletes
      get :works
      get :abnormals
    end
   end
 resources :projects
 
end
