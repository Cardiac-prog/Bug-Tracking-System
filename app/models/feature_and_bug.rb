class FeatureAndBug < ApplicationRecord
  belongs_to :project

  validates :title, :status, :type, :project, presence: true
  validates :title, uniqueness: { scope: :project_id }
  validates :screenshot, format: { with: /\.(png|gif)\z/i, message: "must be a .png or .gif file" }, allow_blank: true
end
