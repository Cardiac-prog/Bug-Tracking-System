class Project < ApplicationRecord
  # has_many :feature_and_bugs, dependent: :destroy                  # one-to-many relation b/w Project -- FeatureAndBug
  validates :title, presence: true

   # has_and_belongs_to_many :users


   # A project is managed by a user (Manager)
   belongs_to :manager, class_name: "User"

   # A project can have many features and bugs
   has_many :feature_and_bugs, dependent: :destroy

   # A project can have many developers and QAs through a join table
   has_and_belongs_to_many :users
end
