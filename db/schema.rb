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

ActiveRecord::Schema.define(version: 20160618230227) do

  create_table "argument_counters", force: :cascade do |t|
    t.integer "argument_id"
    t.integer "counter_id"
  end

  create_table "argument_supporters", force: :cascade do |t|
    t.integer "argument_id"
    t.integer "supporter_id"
  end

  create_table "arguments", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.integer  "creator_id"
    t.boolean  "proponent"
    t.string   "description"
    t.integer  "debate_id"
  end

  create_table "debates", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "creator_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
