class FeatureAndBugPolicy < ApplicationPolicy
  def index?
    user.present? # Any logged-in user can view bugs
  end

  def show?
    user.present? && (
      (user.role == "qa" && record.creator_id == user.id) || # QAs can see their own bugs
      (user.role == "developer" && record.assigned_users.include?(user)) # Developers can see bugs assigned to them
    )
  end

  def create?
    user.role == "qa" # Only QAs can create bugs
  end

  def update?
    (user.role == "qa" && record.creator_id == user.id) ||
    (user.role == "developer" && record.assigned_users.include?(user))
  end

  def destroy?
    user.role == "qa" && record.creator_id == user.id # Only QAs can delete their own bugs
  end

  def assign_to_me?
    user.role == "developer" && record.project.users.include?(user) # Developers can assign bugs to themselves
  end

  def mark_as_resolved?
    user.role == "developer" && record.assigned_users.include?(user)
  end



  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user.role == "developer"
        # Developers can see only bugs in projects they are part of
        scope.joins(:project).where(projects: { id: @user.projects.ids })
      elsif @user.role == "qa"
        # QAs can see only the features and bugs they have created
        scope.where(creator_id: @user.id)
      else
        # Managers can see only bugs in their projects
        scope.joins(:project).where(projects: { manager_id: @user.id })
      end
    end
  end
end
