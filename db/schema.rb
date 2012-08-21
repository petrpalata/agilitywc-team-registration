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

ActiveRecord::Schema.define(:version => 20120818031541) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "breeds", :force => true do |t|
    t.string   "name"
    t.integer  "fci_number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dogs", :force => true do |t|
    t.string   "nickname"
    t.string   "registered_name"
    t.integer  "breed_id"
    t.date     "date_of_birth"
    t.string   "studbook_and_number"
    t.string   "record_book_or_license"
    t.string   "tatoo"
    t.string   "microchip"
    t.string   "microchip_position"
    t.integer  "user_id"
    t.string   "owner_first_name"
    t.string   "owner_last_name"
    t.text     "owner_address"
    t.string   "owner_phone_number"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "handler_id"
    t.string   "category"
    t.boolean  "reserve",                :default => false
    t.string   "sex"
  end

  create_table "handlers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "country_id"
    t.integer  "user_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "insurance",            :limit => 255
    t.integer  "picture_file_size"
    t.string   "picture_content_type"
    t.string   "picture_file_name"
    t.datetime "picture_updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "country_id"
    t.integer  "unique"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "total_teams"
    t.integer  "price_in_euros"
  end

  create_table "super_admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "super_admins", ["email"], :name => "index_super_admins_on_email", :unique => true
  add_index "super_admins", ["reset_password_token"], :name => "index_super_admins_on_reset_password_token", :unique => true

  create_table "team_participations", :force => true do |t|
    t.integer  "country_id"
    t.boolean  "small"
    t.boolean  "medium"
    t.boolean  "large"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "country_id"
    t.integer  "role_cd"
    t.boolean  "confirm_all",            :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
