Depot::Application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  devise_for :accounts, :controllers => { :registrations => 'registrations' }
  resources :orders

  # get '/sellers/:id/edit', :to=>"sellers#edit", as: 'edit_seller'
  # patch '/buyers/:id/edit', :to=> "buyers#edit", as: 'buyer'
  # get '/sellers/:id/edit', :to=>"sellers#edit", as: 'edit_seller'
  # patch '/buyers/:id/edit', :to=> "buyers#edit", as: 'buyer'

  resources :buyers, only: [:edit, :update]
  resources :buyers do
    resources :orders
  end

  resources :sellers, only: [:edit, :update]
  resources :sellers do
    resources :products
  end
  resources :seller do
    resources :orders, only: [:index]
  end

  resources :line_items do
    member do
      patch 'decrement'
    end
  end

  resources :carts

  get "store/index"
  resources :products

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'store#index', as: 'store'
  root 'store#index'

  get '/admin' => 'store#index', as: :admin_account
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
