WebCMS::Application.routes.draw do
  
  resources :groups

  resources :users

  match "/dialogs/:name" => 'dialogs#show'
  resources :videos

  resources :articles

  resources :items do
    post :sort, :on => :collection
  end

  resources :parts

  resources :pages do
    post :move, :on => :collection
  end
  match "/images/insert" => 'images#insert'
  resources :images do
    post  :sort,    :on => :collection
    post  :drop,    :on => :member 
    post  :destroy, :on => :member 
  end

  resources :galleries

  resources :domains

  resources :clients do
    get :change, :on => :member 
  end
  root :to => 'clients#index'
end
