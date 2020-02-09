class CollaborationsController < ApplicationController

  before_action :protected_action

  def show
    render json: Collaboration.where(user_id: params[:user_id], project_id: params[:project_id])
  end

  def joinProjectIfOpen
    user = User.find_by(user_code: collaboration_params[:user_code])
    project = Project.find_by(project_code: collaboration_params[:project_code])
    if Collaboration.where(user: user, project: project).length > 1
      render json: { error: "collaboration already exists"}
    elsif !project.open
      render json: { error: "project is closed" }
    else
      collaboration = Collaboration.new(user: user, project: project, access: project[:default_access], nickname: collaboration_params[:nickname])
      if collaboration.save
        render json: collaboration
      else 
        render json: { error: user.errors.full_messages }, status: 403
      end
    end
  end

  def acceptInvitation
    invitation = Invitation.find_by(id: collaboration_params[:invitation_id])
    user = User.find_by(id: invitation[:user_id])
    project = Project.find_by(project_code: invitation[:project_code])
    if Collaboration.where(user: user, project: project).length > 1
      render json: { error: "collaboration already exists" }
    else
      collaboration = Collaboration.new(user: user, project: project, access: project[:default_access], nickname: collaboration_params[:nickname])
      if collaboration.save
        render json: collaboration
      else 
        render json: { error: user.errors.full_messages }, status: 403
      end
    end
    invitation.destroy
  end

  def delete
    user = User.find_by(id: params[:user_id])
    project = Project.find_by(id: params[:project_id])
    collaboration = Collaboration.where(user: user, project: project)[0]
    collaboration.destroy
  end

  private

  # def joinClosedProject
  #   user = User.find_by(user_code: collaboration_params[:user_code])
  #   project = Project.find_by(project_code: collaboration_params[:project_code])
  #   if Collaboration.where(user: user, project: project).length > 1
  #     render json: "collaboration already exists"
  #   else
  #     collaboration = Collaboration.new(user: user, project: project, access: project[:default_access], nickname: collaboration_params[:nickname])
  #     if collaboration.save
  #       render json: collaboration
  #     else 
  #       render json: { error: user.errors.full_messages }, status: 403
  #     end
  #   end
  # end

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  def collaboration_params
    params.require(:collaboration).permit(:project_code, :user_code, :nickname, :access, :invitation_id)
  end
end
