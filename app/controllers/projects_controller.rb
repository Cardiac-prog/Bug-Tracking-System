class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]
  def index
    @projects = Project.all
  end

  def show
    # find_project through before_action
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project
    else
      render :new, status: :unprocessable_entity  
    end
  end

  def edit
    # find_project through before_action
  end

  def update
    # find_project through before_action

    if @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity  
    end
  end

  def destroy
    # find_project through before_action

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
end
