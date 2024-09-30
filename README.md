# Bug Tracking System

This is a Bug Tracking System that allows users to manage projects and bugs efficiently. The application supports three user roles: Manager, Developer, and QA, each with specific permissions and functionalities.



## Table of Contents

- [Project Functionalities](#project-functionalities)
- [User Roles](#user-roles)
- [Screenshots](#screenshots)
- [Technologies Used](#technologies-used)
- [Installation](#installation)




## Project Functionalities

### Manager Functionalities
- **Create Project:** Managers can create new projects, specifying relevant details.
- **Edit Project:** Managers can edit project information as needed.
- **Delete Project:** Managers can delete projects they created.
- **Manage Users:** Managers can add or remove Developers and QAs from their projects.
- **View Project Details:** Managers can view detailed information about their projects and associated bugs.
- **Search:** Can Search Projects.

### Developer Functionalities
- **View Assigned Projects:** Developers can view only the projects they are a part of.
- **Assign Bug to Self:** Developers can assign bugs to themselves.
- **Mark Bug as Resolved:** After fixing a bug, developers can mark it as resolved.
- **View Bug Details:** Developers can see detailed information about the bugs assigned to them.
- **Search:** Can Search Projects.

### QA Functionalities
- **Report Bugs:** QAs can report bugs for any project they have access to.
- **Add Features:** QAs can propose new features for projects.
- **View All Projects:** QAs have access to view all projects and their details.
- **Search:** Can Search Projects.




## User Roles

### Manager
- Create, edit, and delete projects they create.
- Add/remove Developers and QAs to the projects they create.

### Developer
- Assign bugs to themselves from a list of their projects.
- Can only see projects they are part of.
- Mark bugs as resolved.
- Cannot see other projects, report bugs, or delete bugs.

### QA
- Report bugs for all projects.
- Can view all projects but cannot edit, delete, or create any projects.

### References
- [Authorization with CanCan](http://railscasts.com/episodes/192-authorization-with-cancan)
- [CarrierWave File Uploads](http://railscasts.com/episodes/253-carrierwave-file-uploads)




## Screenshots

### Manager's Dashboard
When the Manager signs in, the following screen is shown:
![Manager Dashboard](https://github.com/user-attachments/assets/09a98065-5de7-4ea6-9ef1-80ab0fee2c18)

### Live Search on Projects
![Live Search](https://github.com/user-attachments/assets/4130967c-a522-42a8-b48b-51bbc3453485)

### Project Details
After clicking on a project, the details screen is displayed:
![Project Details](https://github.com/user-attachments/assets/9de75782-5784-4cad-b7b9-d96d2ed616c5)

### Create Project
The Manager can create a project:
![Create Project](https://github.com/user-attachments/assets/a6d6e0e4-3881-4cad-971c-1965f86b192a)

### QA Dashboard
When QA signs in, the following screen will be shown:
![QA Dashboard](https://github.com/user-attachments/assets/c614e8e5-63a6-484c-a602-2d39fec757a3)

### Add Feature and Report Bugs
QA can "Add Feature" and "Report Bugs":
![Add Feature and Report Bugs](https://github.com/user-attachments/assets/b6133c1d-cb4b-430c-ba64-591fd12ea0d8)

### Add Feature Form
When "Add Feature" is clicked:
![Add Feature Form](https://github.com/user-attachments/assets/1f83aa39-1638-41bc-bd10-e681e2cb0d7d)

### Report Bug Form
When "Report Bug" is clicked:
![Report Bug Form](https://github.com/user-attachments/assets/07119e0f-50f6-414e-83d0-be9d5a82f961)

### Developer Dashboard
When Developer signs in, the following screen is shown:
![Developer Dashboard](https://github.com/user-attachments/assets/7699153d-2266-408a-b011-9174c9de0b04)

### Assign Bug
Developer can assign a bug to themselves:
![Assign Bug](https://github.com/user-attachments/assets/9418042a-c2e2-48c8-bfd5-932b0323d06b)

### Mark the bug as resolved
Developer can change the status of bug to "resolved"
![image](https://github.com/user-attachments/assets/b05ca45a-c6d8-44b5-953b-eafdd8a07030)




## Technologies Used
- Ruby on Rails
- PostgreSQL
- Pundit for role-based authorization
- Sidekiq for background jobs
- CarrierWave for file uploads

## Installation
1. Clone the repository:
   git clone https://github.com/Cardiac-prog/Bug-Tracking-System.git
   
