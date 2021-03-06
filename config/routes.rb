Spinner::Application.routes.draw do
  scope "(:locale)", locale: /en|it/  do
    match '/:locale' => 'spinner#home'

    root to: 'spinner#home'

    resources :users do
      member do
       get :following, :followers, :pending_requests
     end
     resource :blocks, only: [:create, :destroy]
   end

   resources :sessions, only: [:new, :create, :destroy]

   match '/signout', to: 'sessions#destroy', via: :delete
   match '/signin',  to: 'sessions#new'
   match '/signup',  to: 'users#new'
   match '/help' , to: 'spinner#help'

 end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "user_confirmations/new"

  get "password_resets/new"

  #resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy, :update]
  resources :respins, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update] 
  resources :user_confirmations, only: [:new, :show]

  # match '/signout', to: 'sessions#destroy', via: :delete
  # match '/signin',  to: 'sessions#new'
  # match '/signup',  to: 'users#new'
  # match '/help' , to: 'spinner#help'
  

  resources :tags, only: [] do
    get :autocomplete_tag_name, :on => :collection
  end

  resources :spins do
    resources :comments, shallow: true, only: [:create, :destroy]  # create -> nested, destroy simple. See doc if have any doubt
  end

  resources :styles , only: [:edit, :update] do
    member do
        get :show, :format => :css
        put :reset
    end
  end
 
 resources :reports
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
