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

ActiveRecord::Schema.define(version: 20171204013348) do

  create_table "books", force: :cascade do |t|
    t.integer  "ranking",        limit: 4
    t.text     "bookname",       limit: 65535
    t.text     "author",         limit: 65535
    t.integer  "price",          limit: 4
    t.integer  "published_date", limit: 4
    t.text     "publisher",      limit: 65535
    t.text     "image",          limit: 65535
    t.integer  "score",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary",        limit: 65535
    t.text     "autor_data",     limit: 65535
  end

  create_table "databases", force: :cascade do |t|
    t.integer  "ranking",        limit: 4
    t.text     "bookname",       limit: 65535
    t.text     "author",         limit: 65535
    t.integer  "price",          limit: 4
    t.integer  "published_date", limit: 4
    t.text     "publisher",      limit: 65535
    t.text     "image",          limit: 65535
    t.text     "summary",        limit: 65535
    t.text     "author_data",    limit: 65535
    t.integer  "score",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "review",      limit: 65535
    t.integer  "score",       limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "database_id", limit: 4
  end

  add_index "reviews", ["database_id"], name: "index_reviews_on_database_id", using: :btree
  add_index "reviews", ["user_id"], name: "fk_rails_74a66bd6c5", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.text     "handlename",             limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "reviews", "databases"
  add_foreign_key "reviews", "users"
end
