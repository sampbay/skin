Rails.application.routes.draw do


  get 'activate/index'

  get 'how_it_works/index'

  get 'breakout_product_manuals/new'

  get 'safe_product_manuals/new'

  #match '/myproducts/:id', to: 'myproducts#destroy', via: 'delete', defaults: { id: nil }
# match 'myproducts/show' => 'myproducts#show', via => :get


#resources :analyze, :only => [:edit, :update] April 1, 2017
#get '/analyze' => 'analyze#edit' April 1, 2017
resources :products do 
  match :favorite, on: :member, via: [:put, :delete]
end
resources :safe_products
resources :breakout_products

resources :myproducts
#match '/myproducts/edit' => 'myproducts#edit', :via => :get

resources :suggest, only: [:index, :new, :create]
  resources :profiles
  #resources :products do
  #  resources :ingredients
  #end
  resources :search
  root 'profiles#welcome'
  
  # User authentication using Bcrypt
  get '/signup' => 'users#new'
  resources :users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

get '/results' => 'results#index'
get '/recommend' => 'recommend#index'

get '/suggest' => 'suggest#index'
  # autocomplete & search function
resources :favorites

get '/analyze' => 'analyze#index'

resources :password_resets

resources :safe_product_manuals
resources :breakout_product_manuals

get '/privacy_policy' => 'privacy_policy#index'
get '/terms_of_use' => 'terms_of_use#index'
get '/how_it_works' => 'how_it_works#index'
get '/activate' => 'activate#index'

get '/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
