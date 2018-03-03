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

ActiveRecord::Schema.define(version: 20180302215202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locals", force: :cascade do |t|
    t.string "name"
    t.string "max"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "lat"
    t.string "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.boolean "tc"
    t.boolean "active"
    t.string "paypal_oauth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "sn"
    t.integer "value"
    t.string "description"
    t.string "picture_url"
    t.bigint "local_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_vehicles_on_local_id"
  end

end
