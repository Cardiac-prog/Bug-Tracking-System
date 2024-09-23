class RenameTypeColumnInFeatureAndBugs < ActiveRecord::Migration[7.2]
  def change
    rename_column :feature_and_bugs, :type, :item_type
  end
end
