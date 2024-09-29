class ProjectsController < ApplicationController
  before_action :find_project, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_manager, only: [ :new, :create, :edit, :update, :destroy ]
  def index
    @projects = policy_scope(Project)
    authorize Project
  end

  def show
    authorize @project
    get_qas_devs
    @feature_and_bugs = @project.feature_and_bugs

    # Apply filters based on the search parameters
    # @feature_and_bugs = @feature_and_bugs.where(status: params[:status]) if params[:status].present?
    # @feature_and_bugs = @feature_and_bugs.where(item_type: params[:bug_type]) if params[:bug_type].present?
  end

  def new
    @project = Project.new
    set_qas_devs
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.manager = current_user               # assigning the current user id to manager column so that the project table will have the manager id for that specific project created by that specific manager
    authorize @project

    # Assign the QAs and Developers by associating users to the project
    @project.user_ids = params[:project][:qa_ids] + params[:project][:developer_ids]  # this will create and array of qas + developers assigned to a project

    #  project.user_ids is an ActiveRecord setter method that allows you to assign a collection of user IDs to the project. This method is available because of the has_and_belongs_to_many :users association in the Project model.
    # When you assign an array of user IDs to @project.user_ids, ActiveRecord updates the join table (projects_users) and associates those users with the project.


    if @project.save
      redirect_to @project
    else
      set_qas_devs
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # find_project through before_action
    set_qas_devs
    authorize @project
  end

  def update
    # find_project through before_action
    authorize @project

    # Assign the QAs and Developers by associating users to the project
    @project.user_ids = params[:project][:qa_ids] + params[:project][:developer_ids]

    if @project.update(project_params)
      # Send email notifications to all QAs and developers after the project update
      @project.qas.each do |qa|
        ProjectMailer.project_updated_email(@project, qa).deliver_later  # Using deliver_later to send emails in the background via Sidekiq
      end

      @project.developers.each do |developer|
        ProjectMailer.project_updated_email(@project, developer).deliver_later  # Notify developers as well
      end

      redirect_to @project, notice: "Project was successfully updated."
    else
      set_qas_devs
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    # find_project through before_action
    authorize @project

    @project.destroy
    redirect_to root_path
  end


  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def set_qas_devs
    @qas = User.where(role: :qa)
    @developers = User.where(role: :developer)
  end

  def get_qas_devs
    @qas = @project.qas
    @developers = @project.developers
  end

  def authorize_manager
    # Assuming you have a method to check if the current user is a manager
    unless current_user.manager?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to projects_path
    end
  end
end
