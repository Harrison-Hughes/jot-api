Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/myProjects', to: 'projects#index'
  post '/newProject', to: 'projects#newProject'
  get '/projects/:id', to: 'projects#show'
  get '/showCollaborators/:id', to: 'projects#showProjectCollaborators'

  post '/newPad', to: 'pads#newPad'
  get '/pads/:id', to: 'pads#show'

  post '/newPoint', to: 'points#newPoint'

  post '/signin', to: 'users#signin'
  post '/signup', to: 'users#signup'
  get '/validate', to: 'users#validate'

  mount ActionCable.server => '/cable'
end
