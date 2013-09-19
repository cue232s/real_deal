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

ActiveRecord::Schema.define(version: 20130917025548) do

  create_table "hold_deals", force: true do |t|
    t.integer  "property_id"
    t.decimal  "asking_price",            precision: 8, scale: 2
    t.decimal  "aslking_price_per_sq_ft", precision: 8, scale: 2
    t.float    "asking_price_discount"
    t.decimal  "rehab_cost_per_sq_ft",    precision: 8, scale: 2
    t.decimal  "est_arv",                 precision: 8, scale: 2
    t.decimal  "comp_avg_per_sq_ft",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "state"
    t.string   "zillowId"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
