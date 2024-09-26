class CreateBugsUsersJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_table :bugs_users, id: false do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :feature_and_bug, null: false, foreign_key: true
    end
  end
end
