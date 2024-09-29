class ProjectMailer < ApplicationMailer
  default from: "notifications@yourapp.com"

  # Send email notification when a project is updated
  def project_updated_email(project, qa)
    @project = project
    @qa = qa
    @url = Rails.application.routes.url_helpers.project_url(@project, host: "localhost:3000") # Use the appropriate host for your environment
    mail(to: "haidermiraaj04@gmail.com", subject: "Project Update Notification")
  end

  # Send email when a new project is assigned to a QA or developer
  def project_assigned_email(project, user)
    @project = project
    @user = user
    @url = Rails.application.routes.url_helpers.project_url(@project, host: "localhost:3000") # Replace with production host if necessary
    mail(to: "ayaanshahid222@gmail.com", subject: "New Project Assignment")
  end
end
