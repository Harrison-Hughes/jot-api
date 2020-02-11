class CollaborationsController < ApplicationController

  before_action :protected_action

  def show
    user = User.find_by(user_code: params[:user_code]);
    project = Project.find_by(project_code: params[:project_code])
    render json: Collaboration.where(user: user, project: project)
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

  def leaveProject
    user = User.find_by(id: params[:user_id])
    project = Project.find_by(id: params[:project_id])
    collaboration = Collaboration.where(user: user, project: project)[0]
    collaboration.destroy
  end

  def removeOther
    user = User.find_by(user_code: params[:user_code])
    project = Project.find_by(project_code: params[:project_code])
    collaboration = Collaboration.where(user: user, project: project)[0]
    collaboration.destroy
  end

  def updateCollaborationAccess
    user = User.find_by(user_code: params[:user_code])
    project = Project.find_by(project_code: params[:project_code])
    collaboration = Collaboration.where(user: user, project: project)[0]
    collaboration.update(access: collaboration_params[:access])
    render json: collaboration
  end

  def updateCollaborationNickname
    user = User.find_by(user_code: params[:user_code])
    project = Project.find_by(project_code: params[:project_code])
    collaboration = Collaboration.where(user: user, project: project)[0]
    collaboration.update(nickname: collaboration_params[:nickname])
    render json: collaboration
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
