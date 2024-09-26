class CreateJoinTableProjectUser < ActiveRecord::Migration[7.2]
  def change
    create_join_table :projects, :users do |t|
      t.index :project_id
      t.index :user_id
      # You can add unique indexes if necessary
      t.index [ :project_id, :user_id ], unique: true
    end
  end
end
