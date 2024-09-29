class Project < ApplicationRecord
  # has_many :feature_and_bugs, dependent: :destroy                  # one-to-many relation b/w Project -- FeatureAndBug
  validates :title, presence: true

   # has_and_belongs_to_many :users


   # A project is managed by a user (Manager)
   belongs_to :manager, class_name: "User", foreign_key: "manager_id"

   # A project can have many features and bugs
   has_many :feature_and_bugs, dependent: :destroy

   # A project can have many developers and QAs through a join table
   has_and_belongs_to_many :users, class_name: "User", dependent: :destroy


  # To fetch only QAs assigned to the project
  def qas
    users.where(role: :qa)
  end

  # To fetch only developers assigned to the project
  def developers
    users.where(role: :developer)
  end
end
