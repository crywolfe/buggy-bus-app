ActiveRecord::Schema.define(version: 20140426212151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "company_name"
    t.string   "base_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.string   "post"
    t.string   "date"
    t.integer  "rating"
    t.integer  "like"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "departure_date"
    t.string   "departure_time"
    t.string   "departure_location"
    t.string   "arrival_date"
    t.string   "arrival_time"
    t.string   "arrival_location"
    t.string   "duration"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.string   "departure_date"
    t.string   "departure_time"
    t.string   "departure_location"
    t.string   "arrival_date"
    t.string   "arrival_time"
    t.string   "arrival_location"
    t.string   "duration"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
