Rails.application.routes.draw do
  
  root 'home#index'
  get 'search', to:"home#search"
  resources :vacancies, only: %i[index show]

end
