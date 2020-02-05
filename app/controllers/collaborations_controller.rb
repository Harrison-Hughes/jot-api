class CollaborationsController < ApplicationController

  before_action :protected_action

  def show
    render json: Collaboration.where(user_id: params[:user_id], project_id: params[:project_id])
  end

  def joinProject
    user = User.find_by(user_code: collaboration_params[:user_code])
    project = Project.find_by(project_code: collaboration_params[:project_code])
    collaboration = Collaboration.new(user: user, project: project, access: collaboration_params[:access], nickname: collaboration_params[:nickname])
    if collaboration.save
      render json: collaboration
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

  def collaboration_params
    params.require(:collaboration).permit(:project_code, :user_code, :nickname, :access)
  end
end
