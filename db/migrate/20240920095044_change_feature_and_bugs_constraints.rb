class ChangeFeatureAndBugsConstraints < ActiveRecord::Migration[7.2]
  def change
    change_column_null :feature_and_bugs, :title, false
    change_column_null :feature_and_bugs, :status, false
    change_column_null :feature_and_bugs, :type, false
  end
end
