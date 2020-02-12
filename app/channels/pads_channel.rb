class PadsChannel < ApplicationCable::Channel
  def subscribed
    project = Project.find(params[:project])
    stream_for project
  end

  def unsubscribed
    puts <<-EOF
    
    I'm a closed socket! Pads
    
    EOF
  end
end
