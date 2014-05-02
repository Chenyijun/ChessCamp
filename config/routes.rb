ChessCamp::Application.routes.draw do
  get "students/edit"
  get "students/index"
  get "students/new"
  get "students/show"
  get "families/edit"
  get "families/index"
  get "families/new"
  get "families/show"
  get "locations/edit"
  get "locations/new"
  get "locations/index"
  get "locations/show"
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :users
  resources :sessions
  resources :locations
  resources :families
  resources :students

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  # set the root url
  root to: 'home#index'

end
