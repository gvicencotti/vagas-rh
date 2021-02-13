Rails.application.routes.draw do
  
  root 'home#index'
  
  resources :vacancies, only: %i[index show]

end
