class PadsController < ApplicationController

  before_action :protected_action

  def show
    render json: Pad.find(params[:id]).to_json(:include => :points)
  end

  def newPad
    pad = Pad.new(pad_params)
    if pad.save
      render json: pad
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

  def pad_params
    params.require(:pad).permit(:name, :description, :project_id)
  end

end
