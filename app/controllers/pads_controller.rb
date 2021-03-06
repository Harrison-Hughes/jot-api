class PadsController < ApplicationController

  before_action :protected_action

  def show
    pad = Pad.find_by(pad_code: params[:pad_code])
    render json: pad.to_json(:include => [:points])
  end

  def newPad
    pad = Pad.new(pad_params)
    project = Project.find_by(id: pad_params[:project_id])
    if pad.save
      pad.update(pad_code: generatePadCode)
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        PadSerializer.new(pad)
      ).serializable_hash
      PadsChannel.broadcast_to project, serialized_data
      head :ok
    else 
      render json: { error: user.errors.full_messages }, status: 403
    end
  end

  def delete
    pad = Pad.find_by(pad_code: params[:pad_code])
    project = pad.project
    if pad.destroy
      PadsChannel.broadcast_to project, { action: 'delete', id: pad.id }
    end
  end

  def edit
    pad = Pad.find_by(pad_code: params[:pad_code])
    project = pad.project
    if pad.update(name: pad_params[:name], description: pad_params[:description])
      PadsChannel.broadcast_to project, json: { action: 'update', id: pad.id, name: pad_params[:name], description: pad_params[:description]}
    end
    # render json: pad
  end

  private

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  def generatePadCode
    pad_codes = Pad.all.map{ |p| p.pad_code}
    searching = true
    while searching
      code = SecureRandom.hex(3)
      searching = pad_codes.include? code
    end
    return code
  end

  def pad_params
    params.require(:pad).permit(:name, :description, :project_id)
  end

end