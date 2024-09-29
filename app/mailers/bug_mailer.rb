class BugMailer < ApplicationMailer
  default from: "no-reply@example.com" # Change to a valid email

  def bug_assigned(bug, bug_url)
    @bug = bug
    
    mail(to: "haidermiraaj04@gmail.com", subject: "A Bug was assigned to You")
  end
end
