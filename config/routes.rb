TeamRegistration::Application.routes.draw do
  resources :staff_members, :except => [:show]


  get "dogs/index"

  get "dogs/new"

  get "dogs/create"

  get "dogs/edit"

  get "dogs/destroy"

    root :to => "index#index"

    devise_for :users, :skip => ['sessions', 'registrations']

    devise_scope :user do 
        get "/new_user" => "registration#new", :as => 'new_user_registration'
        post "/new_user" => "registration#create", :as => 'create_user_registration'
        get "/users" => "registration#index", :as => 'list_users'
        delete "/user/:id" => "registration#destroy", :as => 'delete_user'
        get "/user/:id/resend_email" => "registration#resend_email", :as => 'user_resend_email'

        get "/login" => "devise/sessions#new", :as => 'new_user_session'
        post "/login" => "devise/sessions#create", :as => 'user_session'
        delete "/logout" => "devise/sessions#destroy", :as => 'destroy_user_session'

        get "/user/:id/switch_country" => "registration#switch_show_country", :as => 'switch_show_country'
    end

    resources :teams
    resources :dogs

    match "/confirmation" => "confirmation#index", :as => 'confirmation_index'
    match "/confirmation/confirm_all" => "confirmation#confirm_all", :as => 'confirmation_confirm_all'
    match "/confirmation/payment_information" => "confirmation#payment_information", :as => 'confirmation_payment_information'
    match "/all_handlers/:country_id/:language" => "index#all_handlers"

    match "/payments/:id/confirm" => "index#confirm_payment", :as => 'payment_confirmation'
    delete "/payments/:id" => "index#delete_payment", :as => 'delete_payment'
    match "/number_information" => "index#number_information"

    match "/export/generate_random_startnumbers" => "export#generate_random_startnumbers"
    match "/export/katalog" => "export#catalogue"
    match "/export/size_and_breed_stats" => "export#size_and_breed_stats"
    match "/export/shirts" => "export#shirts"
    #match "/export/generate_squad_numbers" => "export#generate_squad_numbers"
    match "/export/squads" => "export#squads"
    match "/export/for_main_judge" => "export#for_main_judge"

    scope '/api', defaults: { format: 'json' }, constraints: { format: 'json' } do
        match "/countries" => "api#countries"
        match "/team/:country" => "api#country_teams"
        match "/team/v2/:country" => "api#country_teams_v2"
    end
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

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id))(.:format)'
end
