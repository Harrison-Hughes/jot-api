Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/myProjects/:user_code', to: 'projects#myProjects'
  post '/newProject', to: 'projects#newProject'
  get '/projects/:project_code', to: 'projects#show'
  get '/showCollaborators/:id', to: 'projects#showProjectCollaborators'
  delete '/deleteProject/:project_code', to: 'projects#delete'
  patch '/updateProject/:project_code', to: 'projects#update'

  get '/myInvitations/:user_code', to: 'invitations#myInvitations'
  post '/sendInvitation', to: 'invitations#sendInvitation'
  delete '/declineInvitation/:invitation_id', to: 'invitations#declineInvitation'

  post '/newPad', to: 'pads#newPad'
  get '/pads/:pad_code', to: 'pads#show'
  delete '/deletePad/:pad_code', to: 'pads#delete'

  get '/getCollaboration/:user_id/:project_id', to: 'collaborations#show'
  post '/joinProjectIfOpen', to: 'collaborations#joinProjectIfOpen'
  post '/acceptInvitation', to: 'collaborations#acceptInvitation'
  delete '/leaveProject/:user_id/:project_id', to: 'collaborations#delete'

  post '/newPoint', to: 'points#newPoint'
  delete '/deletePoint/:point_id', to: 'points#delete'

  post '/signin', to: 'users#signin'
  post '/signup', to: 'users#signup'
  get '/validate', to: 'users#validate'
  patch '/updateDefaultNickname/:user_id', to: 'users#updateDefaultNickname'

  mount ActionCable.server => '/cable'
end
