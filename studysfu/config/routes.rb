Rails.application.routes.draw do

  get 'sessions/new'
  # You can have the root of your site routed with "root"
  root 'static_pages#home'
  #root 'user_path'
  #get 'users' => 'sessions#new'

  get 'personalpage' => 'users#show'
  get 'coursepage'   => 'static_pages#coursepage'
  get 'posting'      => 'static_pages#posting'
  get 'about'        => 'static_pages#about'
  get 'contact'      => 'static_pages#contact'
  get 'login'        => 'sessions#new'
  get 'signup'       => 'sessions#new'
  post 'login'       => 'sessions#create'
  delete 'logout'    => 'sessions#destroy'
  get 'chatroom'     => 'users#chatroom'
  post "users/:id/edit"    => "users#edit"
  post "comments/:id" => "comments#edit"
  get 'calendar'    => 'calendars#show'
  get 'events'       => 'events#index'
  get 'conversations'       => 'conversations#index'
  #  get 'resumelists'  =>  'resumelists#index'
  get 'resumelist'      => 'static_pages#resumelist'

  resources :calendar
  resources :events
  resources :resumelists
  resources :resumes
  resources :comments
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :conversations do
    resources :messages
  end

  resources :links do
    member do
      put "like", to:    "links#upvote"
      put "dislike", to: "links#downvote"
    end
    resources :comments
  end
  resources :courses, only: [:index, :show] do
    member do
      get 'info', to: 'courses#info', as: 'get_info'
    end
    collection do
      get 'get_terms',       to: 'courses#get_terms'
      get 'get_departments', to: 'courses#get_departments'
      get 'get_courses',     to: 'courses#get_courses'
    end
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



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
