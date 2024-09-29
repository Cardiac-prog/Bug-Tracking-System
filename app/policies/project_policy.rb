class ProjectPolicy < ApplicationPolicy
  def index?
    user.present? && (
      user.role == "qa" ||
      (user.role == "manager") || # Managers can see all projects
      (user.role == "developer" && user.projects.any?) # Developers can see their projects
    )
  end

  def show?
    user.present? && (
      user.role == "qa" ||
      (user.role == "manager" && record.manager_id == user.id) ||
      (user.role == "developer" && user.projects.include?(record))
    )
  end

  def create?
    user.role == "manager" # Only managers can create projects
  end

  def update?
    user.role == "manager" && (record.manager_id == user.id) # Only managers can edit their own projects
  end

  def destroy?
    user.role == "manager" && (record.manager_id == user.id) # Only managers can delete their own projects
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.role == "qa"
        # QAs can see all projects
        scope.all
      elsif user.role == "manager"
        # Managers can see only the projects they manage
        scope.where(manager_id: user.id)
      elsif user.role == "developer"
        # Developers can see only the projects they are part of
        scope.joins(:projects_users).where(projects_users: { user_id: user.id })
      else
        scope.none
      end
    end
  end
end
