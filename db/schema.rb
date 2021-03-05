# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_05_053451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parties", id: :serial, force: :cascade do |t|
    t.integer "firm_id"
    t.string "company_name", limit: 125
  end

  create_table "powerbi_users", force: :cascade do |t|
    t.string "company_name"
    t.string "username"
    t.string "email"
    t.string "hashed_password"
    t.integer "firm_id"
    t.string "role"
    t.string "group_id"
  end

  create_table "rdids", force: :cascade do |t|
    t.string "reportId"
    t.string "datasetId"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "workspaceId"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "companyId"
    t.string "role"
    t.string "powerBI_enabled"
    t.string "powerBI_user"
    t.string "powerBI_password"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
