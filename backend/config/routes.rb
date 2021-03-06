FloodHack::Application.routes.draw do
	authenticated do
	  root :to => 'alerts#index', as: :authenticated
	end

	devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }
	devise_scope :user do
		get 'log_out' => 'devise/sessions#destroy'
		get 'log_in' => 'devise/sessions#new'
		get 'edit_account' => 'devise/registrations#edit'
  	root to: 'devise/sessions#new'
	end

	resources :users
	resources :alerts

  get 'alerttest' => 'alerts#alertTest'
	get '/local' => 'alerts#index'
	get '/posted_alerts' => 'users#show'

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
