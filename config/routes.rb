Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :currencies
      resources :users, param: :_username
      post '/auth', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
    end
  end
end
