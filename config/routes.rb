WebCMS::Application.routes.draw do
  match '/login'     => "websites#login"
  match '/logout'    => "websites#logout"
  match '/public/*path.:format' => "websites#public"
  resources :groups do
    resources :users
  end
  resources :users do
    post :drop,     :on => :member
    post :destroy,  :on => :member
  end

  resources :videos
  resources :articles

  resources :items do
    post :sort, :on => :collection
  end

  resources :parts
  resources :pages do
    post :move, :on => :collection
  end
  
  resources :images do
    post  :sort,    :on => :collection
    post  :drop,    :on => :member 
    post  :destroy, :on => :member 
  end
  resources :galleries do
    resources :images
  end

  resources :domains
  resources :clients do
    get :change, :on => :member 
  end
  match '/:id(/*path)' => "websites#index"
  root :to => 'websites#index'
end