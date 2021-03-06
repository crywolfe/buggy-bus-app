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

ActiveRecord::Schema.define(version: 20140501142834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string "boston"
    t.string "new_york"
    t.string "philadelphia"
    t.string "baltimore"
    t.string "washington"
    t.string "richmond"
    t.string "hampton"
  end

  create_table "schedules", force: true do |t|
    t.string   "departure_date"
    t.string   "departure_time"
    t.string   "departure_location"
    t.string   "arrival_date"
    t.string   "arrival_time"
    t.string   "arrival_location"
    t.string   "duration"
    t.string   "price"
    t.string   "company_name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.string   "departure_date"
    t.string   "departure_location"
    t.string   "arrival_location"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
