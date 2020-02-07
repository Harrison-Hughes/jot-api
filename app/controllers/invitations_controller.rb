class InvitationsController < ApplicationController

  before_action :protected_action

  def sendInvitation
    user = User.find_by(user_code: invitation_params[:user_code])
    project = Project.find_by(project_code: invitation_params[:project_code])
    if Invitation.where(user: user, project_code: invitation_params[:project_code]).all.length == 0 && !project.users.include?(user)
      invitation = Invitation.new(user: user, project_code: invitation_params[:project_code])
      if invitation.save
        serialized_data = ActiveModelSerializers::Adapter::Json.new(
          InvitationSerializer.new(invitation)
        ).serializable_hash
        InvitationsChannel.broadcast_to user, serialized_data
        head :ok
      else 
        render json: { error: "could not create invitation" }
      end
    elsif project.users.include?(user)
      render json: { error: "user is already a collaborator on this project" }
    else render json: { error: "user has already been invited" }
    end
  end

  def myInvitations
    user = User.find_by(user_code: params[:user_code])
    invitations = Invitation.all.select { |i| i.user == user}
    render json: invitations
  end

  def declineInvitation
    invitation = Invitation.find_by(id: params[:invitation_id])
    invitation.destroy
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
