class InvitationsController < ApplicationController

  before_action :protected_action

  def sendInvitation
    user = User.find_by(user_code: invitation_params[:user_code])
    invitation = Invitation.new(user: user, project_code: invitation_params[:project_code])
    if invitation.save
      render json: invitation
    else 
      render json: { error: user.errors.full_messages }, status: 403
    end
  end

  def myInvitations
    user = User.find_by(user_code: params[:user_code])
    projects = Invitation.all.select { |i| i.users.include?(user)}
    if !projects.empty?
      render json: projects
    end
  end

  private

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  def invitation_params
    params.require(:invitation).permit(:user_code, :project_code)
  end
end
