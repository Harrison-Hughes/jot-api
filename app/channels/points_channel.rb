class PointsChannel < ApplicationCable::Channel
  def subscribed
    pad = Pad.find(params[:pad])
    stream_for pad 
  end

  def unsubscribed
    puts <<-EOF
    
    I'm a closed socket! Points
    
    EOF
  end
end
  