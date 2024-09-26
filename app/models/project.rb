class Project < ApplicationRecord
  has_many :feature_and_bugs, dependent: :destroy                  # one-to-many relation b/w Project -- FeatureAndBug
  validates :title, presence: true

  has_and_belongs_to_many :users
end
