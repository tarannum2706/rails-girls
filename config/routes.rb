Rails.application.routes.draw do
  devise_for :users
  # root to: 'ideas#index'
  root to: redirect('/ideas')
  get'search', to: 'ideas#search'
  resources :ideas
end
