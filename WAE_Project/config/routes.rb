Rails.application.routes.draw do

  get 'application/courses' => 'application#search'
  get 'application/index' => 'application#index'
  get 'home/index'

  get 'content/problemset6' => 'content#problemset6'
  #get '/Problem_set5/public'

  #devise_for :users and added facebook auth need
  devise_for :users, :controllers => {:sessions => 'sessions', :omniauth_callbacks => 'users/omniauth_callbacks'}

  resources :members do

  end

  # Check for the first render page if authenticated
  devise_scope :user do
    authenticated :user do
      root 'exams#home', as: :authenticated_root
    end
    unauthenticated do
      root 'home#index', as: :unauthenticated_root
    end
  end


  concern :the_role, TheRole::AdminRoutes.new
  namespace :admin do
    concerns :the_role
  end

  get 'exams/info' => 'exams#info'

  get 'exams/myuploads' => 'exams#myuploads'

  get '/exams/:id/edit(.:format)' => 'exams#edit' , as: :edit_exam

  get 'exams/home' => 'exams#home'

  get 'exams/:id_school/:id_department/:id_course/new' => 'exams#new'

  post 'exams/:id_school/:id_department/:id_course/create' => 'exams#create'

  get 'exams/:id_school' => 'exams#department'

  get 'exams/:id_school/:id_department' => 'exams#course'

  get 'exams/:id_school/:id_department/:id_course' => 'exams#files'

  get 'exams/:id_school/:id_department/:id_course/upload' => 'exams#upload'

  post 'exams/:id_school/:id_department/:id_course/uploadFile' => 'exams#uploadFile'

  get 'exams/show' => 'exams#show'

  resources :exams


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
