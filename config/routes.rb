Rails.application.routes.draw do
  root 'domains#index'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  resources :domains, only: [:index, :create]
end
