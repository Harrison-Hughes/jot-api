Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/myProjects', to: 'projects#index'
  post '/newProject', to: 'projects#newProject'

  # get `/myProjects/:id`, to: 'projects#show'

  post '/signin', to: 'users#signin'
  post '/signup', to: 'users#signup'
  get '/validate', to: 'users#validate'

  mount ActionCable.server => '/cable'
end
