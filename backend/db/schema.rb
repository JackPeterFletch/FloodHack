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

ActiveRecord::Schema.define(version: 20140216122100) do

  create_table "alerts", force: true do |t|
    t.float    "lat",        default: 0.0
    t.float    "lon",        default: 0.0
    t.string   "address",    default: "",  null: false
    t.string   "alertType",  default: "",  null: false
    t.text     "desc",       default: "",  null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["id"], name: "index_alerts_on_id"
  add_index "alerts", ["user_id"], name: "index_alerts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                                          default: "",  null: false
    t.string   "encrypted_password",                             default: "",  null: false
    t.float    "lat"
    t.float    "lon"
    t.string   "address",                                        default: "",  null: false
    t.string   "postcode",                                       default: "",  null: false
    t.string   "phone"
    t.string   "deviceID"
    t.string   "mobile"
    t.integer  "house_number"
    t.decimal  "alert_radius",           precision: 3, scale: 1, default: 5.0, null: false
    t.string   "auth_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["alert_radius"], name: "index_users_on_alert_radius"
  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["id"], name: "index_users_on_id", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
