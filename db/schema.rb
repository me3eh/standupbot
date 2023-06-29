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

ActiveRecord::Schema.define(version: 2023_06_29_020300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "free_from_standups", force: :cascade do |t|
    t.string "user_id", null: false
    t.date "date_of_beginning"
    t.date "date_of_ending"
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "standup_buffers", force: :cascade do |t|
    t.string "team_id"
    t.string "user_id"
    t.string "message_timestamp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "standup_checks", force: :cascade do |t|
    t.string "user_id", null: false
    t.boolean "morning_stand", default: false
    t.boolean "evening_stand", default: false
    t.date "date_of_stand"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "team"
    t.string "ts_of_message_morning"
    t.string "channel_of_message_morning"
    t.string "ts_of_message_evening"
    t.string "channel_of_message_evening"
    t.text "morning_first"
    t.text "morning_second"
    t.text "morning_third"
    t.text "morning_fourth"
    t.text "evening_first"
    t.text "evening_second"
    t.text "evening_third"
    t.text "evening_fourth"
    t.text "prs_and_estimation"
    t.boolean "open_for_pp"
    t.integer "place", limit: 2
    t.text "morning_fifth"
    t.text "morning_sixth"
    t.text "morning_seventh"
    t.text "morning_eighth"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_id"
    t.string "name"
    t.string "domain"
    t.string "token"
    t.string "oauth_scope"
    t.string "oauth_version", default: "v1", null: false
    t.string "bot_user_id"
    t.string "activated_user_id"
    t.string "activated_user_access_token"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
