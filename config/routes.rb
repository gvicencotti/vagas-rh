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
    resources :candidatures, only: %i[create show]
    get 'user_candidature/:user_id', :to => 'candidatures#users_show', as: 'user_candidature'
    resources :candidature_approvals, only: %i[create show] do
      post 'accept', on: :member
      post 'reject', on: :member
    end
    get 'new/approval/:candidature_id', :to => 'candidature_approvals#new', as: 'new_candidature_approvals' do
    end
    resources :candidature_denials, only: %i[create show]
    get 'new/denial/:candidature_id', :to => 'candidature_denials#new', as: 'new_candidature_denials'

  end

  resources :vacancies, only: %i[index show]

end
