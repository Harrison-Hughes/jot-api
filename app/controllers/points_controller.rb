class PointsController < ApplicationController

  before_action :protected_action

  def newPoint
    point = Point.new(point_params)
    if point.save
      point.update(author: @current_user.user_code)
      render json: point
    else 
      render json: { error: user.errors.full_messages }, status: 403
    end
  end

  private

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  def point_params
    params.require(:point).permit(:text, :location, :pad_id)
  end

end
