Rails.application.routes.draw do
  root 'home#index'
  
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  devise_scope :user do
    get 'users', :to => 'registrations#show', :as => :user
  end
  
  get 'search', to:"home#search"
  
  authenticate :user do
    resources :vacancies, only: %i[new create edit update destroy]
    resources :companies, only: %i[new create show]
    resources :candidatures, only: %i[create]
  end

  resources :vacancies, only: %i[index show]

end
