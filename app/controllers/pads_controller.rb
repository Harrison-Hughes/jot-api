class PadsController < ApplicationController

  before_action :protected_action

  def show
    render json: Pad.find(params[:id]).to_json(:include => :points)
  end

  def newPad
    pad = Pad.new(pad_params)
    project = Project.find_by(id: pad_params[:project_id])
    if pad.save
      pad.update(pad_code: generatePadCode(pad.id))
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        PadSerializer.new(pad)
      ).serializable_hash
      PadsChannel.broadcast_to project, serialized_data
      head :ok
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

  def generatePadCode(id)
    id
  end

  def pad_params
    params.require(:pad).permit(:name, :description, :project_id)
  end

end