class ProjectsController < ApplicationController

  before_action :protected_action

  def newProject
    project = Project.new(project_params)
    if project.save
      project.update(project_code: generateProjectCode(project.id))
      Collaboration.create(user: @current_user, project: project, access: 'admin', nickname: 'nickname')
      render json: project
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

  def project_params
    params.require(:project).permit(:name, :description, :open)
  end

  def generateProjectCode(id)
    id
  end

end
