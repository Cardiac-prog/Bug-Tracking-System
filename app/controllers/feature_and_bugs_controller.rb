class FeatureAndBugsController < ApplicationController
  before_action :find_project, only: %i[new create edit update destroy show]
  before_action :find_feature_and_bugs, only: [ :show, :edit, :update, :destroy, :assign_to_me, :mark_as_resolved ]
  before_action :authorize_feature_and_bug, only: [ :show, :edit, :update, :destroy ]

  def index
    # Use Pundit scope to ensure only relevant records are fetched
    authorize FeatureAndBug
    @feature_and_bugs = policy_scope(FeatureAndBug).where(project: current_user.projects)

    if params[:query].present?
      @feature_and_bugs = @feature_and_bugs.where("title ILIKE :query OR description ILIKE :query", query: "%#{params[:query]}%")
    end
  end

  def show
    # authorize @feature_and_bug
  end

  def new
    # Ensure only QA can create bugs or features
    # authorize FeatureAndBug
    @feature_and_bug = FeatureAndBug.new

    # Set the item_type from the params
    if params[:item_type].present?
      @feature_and_bug.item_type = params[:item_type]

      # Render the appropriate form based on item_type
      case @feature_and_bug.item_type
      when "feature"
        authorize @feature_and_bug
        render "new_feature"
      when "bug"
        authorize @feature_and_bug
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
    # Ensure only QA can create bugs
    # authorize FeatureAndBug
    @feature_and_bug = FeatureAndBug.new(feature_and_bug_params)
    @feature_and_bug.creator = current_user # Assuming creator refers to the user reporting the bug

    authorize @feature_and_bug

    if @feature_and_bug.save
      redirect_to project_feature_and_bug_path(@project, @feature_and_bug), notice: "Successfully created."
    else
      Rails.logger.error(@feature_and_bug.errors.full_messages)
      render @feature_and_bug.item_type == "feature" ? "new_feature" : "new_bug", status: :unprocessable_entity
    end
  end

  def edit
    # authorize @feature_and_bug
  end

  def update
    # authorize @feature_and_bug
    if @feature_and_bug.update(feature_and_bug_params)
      redirect_to project_feature_and_bug_path(@project, @feature_and_bug), notice: "Updated Successfully"
    else
      flash.now[:alert] = "Failed to update Feature or Bug. Please check the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # authorize @feature_and_bug
    @feature_and_bug.destroy
    redirect_to project_path(@project), notice: "Successfully deleted."
  end

  def assign_to_me
    authorize @feature_and_bug, :assign_to_me?

    # Assign the current user to the bug (developer)
    unless @feature_and_bug.assigned_users.include?(current_user)
      @feature_and_bug.assigned_users << current_user
    end

    if @feature_and_bug.save
      @project = @feature_and_bug.project  # Fetch the associated project

      # Send email notification to the developer (current_user)
      BugMailer.bug_assigned(@feature_and_bug).deliver_later  # Using deliver_later for background processing

      redirect_to project_path(@project), notice: "Bug assigned to you successfully."
    else
      @project = @feature_and_bug.project  # Fetch the associated project
      redirect_to project_path(@project), alert: "Failed to assign bug."
    end
  end



  def mark_as_resolved
    @feature_and_bug = FeatureAndBug.find(params[:id])
    authorize @feature_and_bug, :update? # Check authorization for update

    if @feature_and_bug.item_type == "bug"
      @feature_and_bug.status = helpers.bug_status_options.index("resolved")
    elsif @feature_and_bug.item_type == "feature"
      @feature_and_bug.status = helpers.feature_status_options.index("completed")
    end

    if @feature_and_bug.save
      redirect_to project_feature_and_bug_path(@feature_and_bug), notice: "Updated successfully."
    else
      redirect_to project_feature_and_bug_path(@feature_and_bug), alert: "Operation failed."
    end
  end







  private

  def find_project
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end

  def find_feature_and_bugs
    @feature_and_bug = FeatureAndBug.find(params[:id])
  end

  def authorize_feature_and_bug
    authorize @feature_and_bug
  end

  def feature_and_bug_params
    params.require(:feature_and_bug).permit(:title, :description, :project_id, :deadline, :screenshot, :status, :item_type)
  end
end
