class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { manager: 0, qa: 1, developer: 2 }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :name, presence: true

  # A user can manage many projects
  has_many :managed_projects, class_name: "Project", foreign_key: "manager_id"

  # A user can report many bugs
  has_many :reported_bugs, class_name: "FeatureAndBug", foreign_key: "creator_id"

  # A user can be assigned many bugs
  has_and_belongs_to_many :assigned_bugs, class_name: "FeatureAndBug", join_table: "bugs_users"

  # A user can belong to many projects (both developer and QA)
  has_and_belongs_to_many :projects
end
