TestApp::Application.routes.draw do |map|
  
  resources :tags
  devise_for :users
  
  constraints(:subdomain => /.+/) do
    resources :wishes, :path => "" do   
      get :add_vote, :on => :member   
    end 
    root :to => "wishes#index"
  end
  
  resources :issues

  root :to => "issues#index"

end
