class ProjectsController < ApplicationController

  before_action :protected_action

  def index
    projects = Project.all.select { |p| p.users.include?(@current_user)}
    if !projects.empty?
      render json: projects
    end
  end

  def show
    render json: Project.find_by(project_code: params[:id]).to_json(:include => :pads)
  end

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

  def showProjectCollaborators
    collaborations = Project.find_by(project_code: params[:id]).collaborations
    render json: renderCollabs(collaborations)
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

  def renderCollabs(collaborations)
    collaborations.map{ |collab| {user_code: collab.user.user_code, nickname: collab.nickname}}
  end

end
