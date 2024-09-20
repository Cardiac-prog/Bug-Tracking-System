class CreateFeatureAndBugs < ActiveRecord::Migration[7.2]
  def change
    create_table :feature_and_bugs do |t|
      t.string :title
      t.text :description
      t.references :project, null: false, foreign_key: true
      t.date :deadline
      t.string :screenshot
      t.integer :status
      t.integer :type

      t.timestamps
    end
    add_index :feature_and_bugs, [ :title, :project_id ], unique: true   # composite unique index for title and project id. It ensures that a title can be unique for a specific project
  end
end
