TestApp::Application.routes.draw do |map|
  
  constraints(:subdomain => /.+/) do
    resources :wishes, :path => "" do   
      get :add_vote, :on => :member   
    end 
    match "/", :to => "wishes#index"
  end

  resources :issues

  resource :account, :controller => "users"
  resources :users
  resource :session, :controller => "user_sessions"

  match "/signup" => "users#new", :as => :signup
  match "/signin" => "user_sessions#new", :as => :signin
  match "/signout" => "user_sessions#destroy", :as => :signout
 
  root :to => "issues#index"

  match ':controller(/:action(/:id(.:format)))'
end
