class PointsChannel < ApplicationCable::Channel
  def subscribed
    pad = Pad.find(params[:pad])
    stream_for pad 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
