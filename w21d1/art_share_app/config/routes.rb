Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [ :show, :get, :update, :destroy, :create, :index] do 
    resources :artworks, only: [:index]
    resources :artwork_collections, only: [:index]
    member do 
      post 'create_collection'
      # delete delete_collection
    end
  end

  resources :artworks, only: [ :show, :update, :destroy, :create] do 
    member do 
      patch 'favorite'
      patch 'unfavorite'
      post 'like'
      patch 'unlike'
      post 'comment'
      #delete 'uncomment'
    end
  end 

  resources :artwork_shares, only: [ :create, :destroy ] do 
    member do 
      patch 'favorite'
      patch 'unfavorite'
    end
  end


  resources :comments, only: [:create, :destroy, :index] do 
    member do 
      post 'like'
      patch 'unlike'
    end
  end


  resources :artwork_collections, only: [:create, :show, :destroy] do 
    resources :artworks, only: [:index] do 
      post 'add_to_collection'
      delete 'remove_from_collection'
    end
  end


  # get "/users", to: "users#index", as: "users"
  # post "/users", to: "users#create"
  # get "/users/new", to: "users#new", as: "new_user"
  # get "/users/:id/edit", to: "users#edit", as: "edit_user"
  # get "/users/:id", to: "users#show", as: "user"
  # patch "/users/:id", to: "users#update"
  # put "/users/:id", to: "users#update"
  # delete "/users/:id", to: "users#destroy"



  
end