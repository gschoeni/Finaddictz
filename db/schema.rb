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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120925203117) do

  create_table "angler_exts", :force => true do |t|
    t.date     "fishing_license_exp"
    t.text     "about"
    t.string   "experience"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "angler_posts", :force => true do |t|
    t.integer  "num_people"
    t.integer  "price_min"
    t.integer  "price_max"
    t.date     "date"
    t.string   "time"
    t.text     "description"
    t.boolean  "search_guide"
    t.boolean  "search_angler"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "user_id"
    t.integer  "river_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "booking_status_id"
  end

  create_table "booking_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", :force => true do |t|
    t.string   "title"
    t.integer  "user_id1"
    t.integer  "user_id2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new_message", :default => true
  end

  create_table "env_prefs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fish_species", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fishing_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guide_exts", :force => true do |t|
    t.date     "fishing_license_exp"
    t.text     "about"
    t.string   "experience"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guide_posts", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.integer  "num_people"
    t.integer  "price_per"
    t.date     "date"
    t.string   "time"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.boolean  "abusive_flag",      :default => false
    t.integer  "river_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "booking_status_id"
  end

  create_table "locations", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.integer  "radius"
    t.boolean  "gmaps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "text"
    t.boolean  "read",            :default => false
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notification_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "notification_type"
    t.string   "title"
    t.string   "message"
    t.integer  "related_id"
    t.boolean  "read",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prop_exts", :force => true do |t|
    t.text     "about"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "river_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "booking_status_id"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "stars"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rivers", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "keyword"
    t.integer  "radius"
    t.boolean  "gmaps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "readable_name"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "trips_to_users", :force => true do |t|
    t.integer  "post_id"
    t.integer  "post_booking_status_id"
    t.integer  "user_who_posted_id"
    t.integer  "user_who_agreed_id"
    t.boolean  "trip_has_been_finished", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "state"
    t.string   "birthdate"
    t.string   "active_role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "notify_email",       :default => false
    t.boolean  "notify_sms",         :default => false
    t.boolean  "notify_phone",       :default => false
    t.boolean  "notify_site",        :default => false
    t.boolean  "confirmed",          :default => false
    t.boolean  "enable",             :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

end
