SampleApp::Application.routes.draw do

  get "users/new"

  # Enable Rails REST-style URI's for users
  # HTTP    URI         Action      Named            Purpose
  # request                         route
  # GET   /users        index   users_path page   to list all users
  # GET   /users/1      show    user_path(user)   page to show user
  # GET   /users/new    new     new_user_path     page to make a new user (signup)
  # POST  /users        create  users_path        create a new user
  # GET   /users/1/edit edit    edit_user_path(user) page to edit user with id 1
  # PUT   /users/1      update  user_path(user)   update user
  # DELETE /users/1     destroy user_path(user)   delete user
  #
  # resources   :users

  # get "initial_pages/home"
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  #
  root to: 'initial_pages#home'
  #
  # Above creates:
  # root_path => '/'
  # root_url => 'http://localhost:3000/'
  #
  match '/signup',  to: 'users#new'
  #
  # get "initial_pages/help"
  # get "initial_pages/about"
  # get "initial_pages/contact"
  # Above replaced with what is following:
  #
  match '/help',    to: 'initial_pages#help'
  match '/about',   to: 'initial_pages#about'
  match '/contact', to: 'initial_pages#contact'
  #
  # The above automaticall creates help_path, about_path, 
  # and contact_path.
  # Automatically creates named routes, example:
  # about_path => '/about'
  # about_url => 'http://localhost:3000/about
  # 

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
