class CollaborationsController < ApplicationController

  before_action :protected_action

  def show
    render json: Collaboration.where(user_id: params[:user_id], project_id: params[:project_id])
  end

  private

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  # def collaboration_params
  #   params.require(:collaboration).permit(:project_id, :user_id)
  # end
end
