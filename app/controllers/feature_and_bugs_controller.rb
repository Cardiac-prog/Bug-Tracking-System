class FeatureAndBugsController < ApplicationController
  before_action :find_feature_and_bugs, only: [:show, :edit, :update, :destroy]
  before_action :find_project, only: %i[new create edit update destroy show]

  def index
    @feature_and_bugs = FeatureAndBug.all
  end

  def show
    # find project
  end

  def new
    @feature_and_bug = FeatureAndBug.new

    # Set the item_type from the params
    if params[:item_type].present?
      @feature_and_bug.item_type = params[:item_type]

      # Render the appropriate form based on item_type
      case @feature_and_bug.item_type
      when "feature"
        render "new_feature"
      when "bug"
        render "new_bug"
      else
        flash[:alert] = "Invalid type"
        redirect_to project_path(@project)
      end
    else
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
      flash.now[:alert] = "Failed to create Feature or Bug. Please check the errors below."
      render @feature_and_bug.item_type == "feature" ? "new_feature" : "new_bug", status: :unprocessable_entity
    end
  end

  def edit
    # @feature_and_bug is set by before_action
  end

  def update
    if @feature_and_bug.update(feature_and_bug_params)
      redirect_to project_feature_and_bug_path(@project, @feature_and_bug), notice: "Updated Successfully"
    else
      flash.now[:alert] = "Failed to update Feature or Bug. Please check the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feature_and_bug.destroy
    redirect_to project_path(@project), notice: "Successfully deleted."
  end

  private

  def find_feature_and_bugs
    @feature_and_bug = FeatureAndBug.find(params[:id])
  end

  def feature_and_bug_params
    params.require(:feature_and_bug).permit(:title, :description, :project_id, :deadline, :screenshot, :status, :item_type)
  end

  def find_project
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end
end
