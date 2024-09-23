# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_23_105551) do
  create_table "feature_and_bugs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "project_id", null: false
    t.date "deadline"
    t.string "screenshot"
    t.integer "status", null: false
    t.integer "item_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_feature_and_bugs_on_project_id"
    t.index ["title", "project_id"], name: "index_feature_and_bugs_on_title_and_project_id", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "feature_and_bugs", "projects"
end
