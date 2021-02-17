Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users
  
  get 'search', to:"home#search"
  resources :vacancies, only: %i[index show new create]

end
