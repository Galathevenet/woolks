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

ActiveRecord::Schema.define(version: 2022_03_02_094536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_walks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "walk_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favorite_walks_on_user_id"
    t.index ["walk_id"], name: "index_favorite_walks_on_walk_id"
  end

  create_table "hotspot_walks", force: :cascade do |t|
    t.bigint "hotspot_id", null: false
    t.bigint "walk_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspot_id"], name: "index_hotspot_walks_on_hotspot_id"
    t.index ["walk_id"], name: "index_hotspot_walks_on_walk_id"
  end

  create_table "hotspots", force: :cascade do |t|
    t.string "category"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "walk_id", null: false
    t.bigint "user_id", null: false
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["walk_id"], name: "index_reviews_on_walk_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "walks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.date "date"
    t.float "length"
    t.boolean "published"
    t.float "start_point_latitude"
    t.float "start_point_longitude"
    t.float "end_point_latitude"
    t.float "end_point_longitude"
    t.bigint "user_id", null: false
    t.bigint "original_walk_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "duration"
    t.index ["original_walk_id"], name: "index_walks_on_original_walk_id"
    t.index ["user_id"], name: "index_walks_on_user_id"
  end

  create_table "waypoints", force: :cascade do |t|
    t.bigint "walk_id", null: false
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["walk_id"], name: "index_waypoints_on_walk_id"
  end

  add_foreign_key "favorite_walks", "users"
  add_foreign_key "favorite_walks", "walks"
  add_foreign_key "hotspot_walks", "hotspots"
  add_foreign_key "hotspot_walks", "walks"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "walks"
  add_foreign_key "walks", "users"
  add_foreign_key "walks", "walks", column: "original_walk_id"
  add_foreign_key "waypoints", "walks"
end
