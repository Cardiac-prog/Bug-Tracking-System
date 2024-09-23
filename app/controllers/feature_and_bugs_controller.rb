class FeatureAndBugsController < ApplicationController
  before_action :find_featureAndBugs, only: [ :show, :edit, :update, :destroy ]
  before_action :find_project, only: %i[new create edit update destroy]
  def index
    @feature_and_bugs = FeatureAndBug.All
  end

  def show
    # find_featureAndBugs through before_action
    # @feature_and_bugs = @project.feature_and_bugs
  end

  def new
    @feature_and_bug = FeatureAndBug.new

    # Set the item_type from the params
    if params[:item_type].present?
      @feature_and_bug.item_type = params[:item_type]

      # Render the appropriate form based on item_type
      if @feature_and_bug.item_type == "feature"
        render "new_feature"
      elsif @feature_and_bug.item_type == "bug"
        render "new_bug"
      else
        # Handle invalid types
        flash[:alert] = "Invalid type"
        redirect_to project_path(@project)
      end
    else
      # If no type is provided, redirect or handle accordingly
      flash[:alert] = "Type is required to create a new entry."
      redirect_to project_path(@project)
    end
  end





  def create
    @feature_and_bug = FeatureAndBug.new(feature_and_bug_params)
    @feature_and_bug.project_id = params[:project_id]

    if @feature_and_bug.save
      redirect_to project_feature_and_bug_path(@project, @feature_and_bug), notice: "Successfully created."
    else
      # Render the appropriate form based on item_type if save fails
      if @feature_and_bug.item_type == "feature"
        render "new_feature", status: :unprocessable_entity
      elsif @feature_and_bug.item_type == "bug"
        render "new_bug", status: :unprocessable_entity
      else
        flash[:alert] = "Invalid type"
        redirect_to project_path(@project)
      end
    end
  end





  def edit
    # find_featureAndBugs through before_action
  end

  def update
    # find_featureAndBugs through before_action
    if @feature_and_bug.update(feature_and_bug_params)
      redirect_to project_feature_and_bug_path(@project, @feature_and_bug), notice: "Updated Successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # find_featureAndBugs through before_action
    @feature_and_bug.destroy
    redirect_to @project
  end



  private

  def find_featureAndBugs
    @feature_and_bug = FeatureAndBug.find(params[:id])
  end

  def feature_and_bug_params
    params.require(:feature_and_bug).permit(:title, :description, :project_id, :deadline, :screenshot, :status, :item_type)
  end

  def find_project
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end
end
