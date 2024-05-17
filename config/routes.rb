Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }
  # Defines the root path route ("/")
  # root "articles#index"
end
