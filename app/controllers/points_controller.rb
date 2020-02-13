class PointsController < ApplicationController

  before_action :protected_action

  def newPoint
    pad = Pad.find(point_params[:pad_id])
    loc = point_params[:location]
    if loc == "temp"
      pointLocations = pad.points.map{ |p| p.location.to_i}
      loc = pointLocations.max + 1
    end
    point = Point.new(text: point_params[:text], author: point_params[:author], location: loc, pad: pad)
    if point.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        PointSerializer.new(point)
      ).serializable_hash
      PointsChannel.broadcast_to pad, serialized_data
      head :ok
    else 
      render json: { error: user.errors.full_messages }, status: 403
    end
  end

  def editPoint
    point = Point.find_by(id: params[:point_id])
    pad = point.pad
    if point.update(text: point_params[:text])
      PointsChannel.broadcast_to pad, json: { action: 'update', id: point.id, text: point_params[:text]}
    end
  end

  def delete
    point = Point.find_by(id: params[:point_id])
    pad = point.pad
    if point.destroy
      PointsChannel.broadcast_to pad, json: { action: 'delete', id: point.id }
    end
  end

  private

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  def point_params
    params.require(:point).permit(:text, :location, :author, :pad_id)
  end

end
