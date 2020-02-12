class InvitationsChannel < ApplicationCable::Channel
  def subscribed
    user = User.find(params[:user])
    stream_for user  
  end

  def unsubscribed
    puts <<-EOF
    
    I'm a closed socket! Invitations
    
    EOF
  end
end
