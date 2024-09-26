class FeatureAndBug < ApplicationRecord
  mount_uploader :screenshot, ImageUploader     # This will tell rails that screenshot solumn of featureAndBug table will be handled by image uploader

  # belongs_to :project
  # has_and_belongs_to_many :users, join_table: :bugs_users

  # A bug or feature belongs to a project
  belongs_to :project

  # A bug or feature is created by a QA
  belongs_to :creator, class_name: "User"

  # A bug or feature is assigned to a developer
  has_and_belongs_to_many :assigned_users, class_name: "User", join_table: "bugs_users"

  validates :title, :status, :item_type, :project, presence: true
  validates :title, uniqueness: { scope: :project_id }
  validates :screenshot, format: { with: /\.(png|gif)\z/i, message: "must be a .png or .gif file" }, allow_blank: true

  enum item_type: {  feature: 0, bug: 1 }

  def formatted_deadline
    deadline.strftime("%d-%m-%y") if deadline
  end
end
