Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  devise_scope :user do
    get 'users', :to => 'registrations#show', :as => :user
  end
  
  get 'search', to:"home#search"
  resources :vacancies, only: %i[index show new create edit update destroy]

end
