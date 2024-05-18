Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  resources :domains, only: [:index, :new, :create]
  # Defines the root path route ("/")
  # root "articles#index"
end
