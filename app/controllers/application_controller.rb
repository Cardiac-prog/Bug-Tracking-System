class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!

  # include Pundit::Authorization

  def after_sign_in_path_for(resource)
    projects_path # Redirect to the dashboard after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirect to the homepage after sign-out
  end

  allow_browser versions: :modern

  include Pundit

  # Optional: Handle unauthorized access
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to projects_path
  end
end
