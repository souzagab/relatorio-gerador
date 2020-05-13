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

ActiveRecord::Schema.define(version: 2020_05_03_212442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company"
    t.string "educational_institution"
    t.integer "worked_days"
    t.integer "daily_worked_hours"
    t.date "report_date"
    t.text "performed_activities"
    t.date "canceled_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "professor_id"
    t.bigint "supervisor_id"
  end

  create_table "signatures", force: :cascade do |t|
    t.bigint "subscriber_id", null: false
    t.text "uuid", default: "uuid_generate_v4()", null: false
    t.string "sign"
    t.text "audits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscriber_id"], name: "index_signatures_on_subscriber_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "user_id"
    t.string "celphone"
    t.string "email", null: false
    t.string "name", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.string "remember_token"
    t.string "picture"
    t.boolean "admin"
    t.boolean "coordenador"
    t.boolean "supervisor"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "signatures", "subscribers"
end
