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

ActiveRecord::Schema.define(version: 20170511140657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "expenses", force: :cascade do |t|
    t.date     "issue_date",       null: false
    t.integer  "category_id"
    t.string   "employee_name",    null: false
    t.string   "employee_address"
    t.text     "description"
    t.float    "pre_tax_amount",   null: false
    t.string   "tax_name"
    t.float    "tax_amount"
    t.float    "after_tax_amount", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "expenses", ["category_id"], name: "index_expenses_on_category_id", using: :btree

  add_foreign_key "expenses", "categories"
end
