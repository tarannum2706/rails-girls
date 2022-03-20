Rails.application.routes.draw do
  get 'pages/info'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root 'ideas#search'
  root to: redirect('/ideas')
  get'search', to: 'ideas#search'
  resources :ideas do
  end
end
