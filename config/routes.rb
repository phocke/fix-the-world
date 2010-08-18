TestApp::Application.routes.draw do |map|
  
  root :to => "issues#index"
  resources :tags
  devise_for :users
  
  constraints(:subdomain => /.+/) do
    #match "/signup" => "users#new", :as => :signup
    #match "/signin" => "user_sessions#new", :as => :signin
    #match "/signout" => "user_sessions#destroy", :as => :signout
 
    resources :wishes, :path => "" do   
      get :add_vote, :on => :member   
    end 
    match "/", :to => "wishes#index"
  end
  match "/issues/new" => "issues#new"
  match "/issues/:id" => "wishes#index"
  
  resources :issues
  #resource :account, :controller => "users"
  #resources :users
  #resource :session, :controller => "user_sessions"

  #match "/signup" => "users#new", :as => :signup
  #match "/signin" => "user_sessions#new", :as => :signin
  #match "/signout" => "user_sessions#destroy", :as => :signout
 
  

  #match ':controller(/:action(/:id(.:format)))'
end
