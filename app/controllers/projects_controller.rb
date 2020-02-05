class ProjectsController < ApplicationController

  before_action :protected_action

  def index
    projects = Project.all.select { |p| p.users.include?(@current_user)}
    if !projects.empty?
      render json: projects
    end
  end

  def myProjects
    user = User.find_by(user_code: params[:user_code])
    projects = Project.all.select { |p| p.users.include?(user)}
    if !projects.empty?
      render json: projects
    end
  end

  def show
    render json: Project.find_by(project_code: params[:project_code]).to_json(:include => :pads)
  end

  def newProject
    user = User.find_by(user_code: project_params[:user_code])
    project = Project.new(name: project_params[:name], description: project_params[:description], open: project_params[:open])
    if project.save
      project.update(project_code: generateProjectCode(project.id))
      Collaboration.create(user: user, project: project, access: 'admin', nickname: 'admin')
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
    params.require(:project).permit(:user_code, :name, :description, :open)
  end

  def generateProjectCode(id)
    id
  end

  def renderCollabs(collaborations)
    collaborations.map{ |collab| {user_code: collab.user.user_code, nickname: collab.nickname}}
  end

end
