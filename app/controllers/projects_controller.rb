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
    else render json: { error: "you have no projects" }, status: 204
    end
  end

  def show
    render json: Project.find_by(project_code: params[:project_code]).to_json(:include => :pads)
  end

  def newProject
    user = User.find_by(user_code: project_params[:user_code])
    project = Project.new(name: project_params[:name], description: project_params[:description], open: project_params[:open], default_access: project_params[:default_access])
    if project.save
      project.update(project_code: generateProjectCode)
      Collaboration.create(user: user, project: project, access: 'admin', nickname: user.default_nickname)
      render json: project
    else 
      render json: { error: "could not create project" }, status: 403
    end
  end

  def showProjectCollaborators
    collaborations = Project.find_by(project_code: params[:project_code]).collaborations
    render json: renderCollabs(collaborations)
  end

  def delete 
    project = Project.find_by(project_code: params[:project_code])
    project.destroy
  end

  def update
    project = Project.find_by(project_code: params[:project_code])
    project.update(project_params)
    render json: project
  end

  private

  def protected_action
    if !logged_in?
        render json: { errors: 'you must be logged in'}, status: :unauthorized
    end
  end

  def project_params
    params.require(:project).permit(:user_code, :name, :description, :open, :default_access)
  end

  def generateProjectCode
    project_codes = Project.all.map{ |p| p.project_code}
    searching = true
    while searching
      code = SecureRandom.hex(3)
      searching = project_codes.include? code
    end
    return code
  end

  def renderCollabs(collaborations)
    collaborations.map{ |collab| {user_code: collab.user.user_code, nickname: collab.nickname, access: collab.access}}
  end

end
