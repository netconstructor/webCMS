WebCMS::Application.routes.draw do
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
