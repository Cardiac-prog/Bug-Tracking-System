class AddCreatorIdToFeatureAndBugs < ActiveRecord::Migration[7.2]
  def change
    # Add the creator_id column
    add_column :feature_and_bugs, :creator_id, :integer, null: false

    # Add foreign key constraint for creator_id
    add_foreign_key :feature_and_bugs, :users, column: :creator_id
  end
end
