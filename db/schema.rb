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

ActiveRecord::Schema.define(version: 20150628214743) do

  create_table "members", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "gender"
    t.integer  "age"
    t.text     "about_me"
    t.string   "status"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_send_at"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true

  create_table "timelines", force: :cascade do |t|
    t.text     "content"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "timelines", ["member_id", "created_at"], name: "index_timelines_on_member_id_and_created_at"
  add_index "timelines", ["member_id"], name: "index_timelines_on_member_id"

end
