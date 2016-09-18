# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160918113254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string  "street"
    t.string  "city"
    t.integer "postal_code"
    t.string  "country"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "location_id"
    t.string  "region"
  end

  add_index "addresses", ["location_id"], name: "index_addresses_on_location_id", using: :btree

  create_table "available_dates", force: :cascade do |t|
    t.integer "location_id"
    t.boolean "reserved",       default: false
    t.date    "available_date"
  end

  add_index "available_dates", ["location_id"], name: "index_available_dates_on_location_id", using: :btree

  create_table "location_images", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "caption"
    t.integer  "picture_order"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
  end

  add_index "location_images", ["location_id"], name: "index_location_images_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "beds"
    t.integer  "guests"
    t.float    "price"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",   default: false
  end

  add_index "locations", ["member_id"], name: "index_locations_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stripe_access_token"
    t.string   "stripe_refresh_token"
    t.string   "stripe_publishable_key"
    t.string   "stripe_user_id"
    t.string   "provider"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "postal_code"
    t.string   "state"
    t.date     "birthday"
    t.integer  "cc_number"
    t.integer  "member_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.text     "bio"
    t.boolean  "is_host"
  end

  add_index "profiles", ["member_id"], name: "index_profiles_on_member_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.date    "start_date"
    t.date    "end_date"
    t.integer "location_id"
    t.integer "member_id"
    t.integer "id_for_credit_card_charge"
  end

  add_index "reservations", ["location_id"], name: "index_reservations_on_location_id", using: :btree
  add_index "reservations", ["member_id"], name: "index_reservations_on_member_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "locations"
  add_foreign_key "available_dates", "locations"
  add_foreign_key "location_images", "locations"
  add_foreign_key "reservations", "locations"
  add_foreign_key "reservations", "members"
end
