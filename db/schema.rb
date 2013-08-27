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

ActiveRecord::Schema.define(:version => 20130825144734) do

  create_table "blacklisted_users", :id => false, :force => true do |t|
    t.integer  "blocker_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blacklisted_users", ["blocker_id", "user_id"], :name => "index_blacklisted_users_on_blocker_id_and_user_id", :unique => true
  add_index "blacklisted_users", ["blocker_id"], :name => "index_blacklisted_users_on_blocker_id"
  add_index "blacklisted_users", ["user_id"], :name => "index_blacklisted_users_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "body"
    t.integer  "spin_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "approved",    :default => true
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "respins", :force => true do |t|
    t.integer  "respinner_id"
    t.integer  "spin_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "respins", ["respinner_id", "spin_id"], :name => "index_respins_on_respinner_id_and_spin_id", :unique => true
  add_index "respins", ["respinner_id"], :name => "index_respins_on_respinner_id"
  add_index "respins", ["spin_id"], :name => "index_respins_on_spin_id"

  create_table "spins", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "type"
    t.string   "multimedia_file_name"
    t.string   "multimedia_content_type"
    t.integer  "multimedia_file_size"
    t.datetime "multimedia_updated_at"
  end

  create_table "styles", :force => true do |t|
    t.integer  "user_id"
    t.string   "well_color"
    t.string   "background_color"
    t.boolean  "nav_inverse",      :default => true
    t.string   "background_image"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "username"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "confirmed_user",         :default => false
    t.string   "user_confirm_token"
    t.datetime "user_confirm_sent_at"
    t.boolean  "private",                :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
