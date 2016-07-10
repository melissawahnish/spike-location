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

ActiveRecord::Schema.define(version: 20160708150813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "location_images", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "caption"
    t.integer  "picture_order"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "location_images", ["location_id"], name: "index_location_images_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "zip"
  end

  add_foreign_key "location_images", "locations"
end
