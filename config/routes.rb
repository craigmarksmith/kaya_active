Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'landing#index'

  get 'collection/:category/:slug' => 'products#show', as: :product
  get 'collection/' => 'products#index', as: :products
  get 'collection/:category' => 'products#index', as: :category_products

  get 'blog' => 'blog_posts#index', as: :blog_posts
  get 'blog/:blog_post_slug' => 'blog_posts#show', as: :blog_post

  get 'contact-us' => 'contact#show', as: 'contact'
  resources :enquiries, only: [:new, :create]
  get 'enquiry/sent' => 'enquiries#thankyou', as: 'thankyou'

  resources :purchases, only: [:new, :create]
  get 'purchases/complete' => 'purchases#complete', as: 'complete'
  get 'purchases/price' => 'purchases#price', as: 'purchase_price'

  get 'shipping' => 'static#shipping', as:'shipping'
  get 'returns' => 'static#returns', as:'returns'
  get 'privacy' => 'static#privacy', as:'privacy'
  get 'terms' => 'static#terms', as:'terms'
  get 'about' => 'static#about', as:'about'



  get 'status' => 'status#show', as:'status'

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

  get '*unmatched_route', :to => 'application#raise_not_found!' if Rails.env == 'production'
end
