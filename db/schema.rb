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

ActiveRecord::Schema.define(:version => 20130519204042) do

  create_table "catalogs", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "ancestry"
    t.boolean  "has_files",        :default => false
    t.integer  "catalogable_id"
    t.string   "catalogable_type"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "catalogs", ["ancestry"], :name => "index_catalogs_on_ancestry"

  create_table "dicom_files", :force => true do |t|
    t.string   "dicom_file_name"
    t.string   "dicom_content_type"
    t.integer  "dicom_file_size"
    t.datetime "dicom_updated_at"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "catalog_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "dicom_thumb_file_name"
    t.string   "dicom_thumb_content_type"
    t.integer  "dicom_thumb_file_size"
    t.datetime "dicom_thumb_updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "catalog_creation", :default => false
  end

  create_table "groups_projects", :force => true do |t|
    t.integer  "group_id"
    t.integer  "project_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "share",      :default => false
  end

  create_table "groups_users", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "share",      :default => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "subject_id"
    t.string   "subject"
    t.text     "content"
    t.boolean  "opened",           :default => false
    t.boolean  "deleted",          :default => false
    t.boolean  "copies",           :default => false
    t.string   "ancestry"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "request"
    t.boolean  "request_accepted", :default => false
  end

  add_index "messages", ["user_id", "subject_id", "ancestry"], :name => "messages_idx"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.string   "permissionable_type"
    t.integer  "permissionable_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "catalog_creation", :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "surname"
    t.boolean  "admin",                  :default => false
    t.boolean  "enabled"
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roles",                  :default => "--- []"
  end

end
