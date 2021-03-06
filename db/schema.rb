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

ActiveRecord::Schema.define(version: 20180525030740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.integer "vendor_id"
  end

  create_table "orders", force: :cascade do |t|
    t.text "description"
    t.decimal "order_amount"
    t.string "invoice_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vendor"
    t.string "show"
    t.string "contact"
    t.datetime "ship_on"
    t.datetime "received_on"
    t.integer "term"
    t.decimal "shipping_percentage"
    t.decimal "order_amount_with_shipping"
    t.datetime "ordered_on"
    t.integer "payable_id"
  end

  create_table "payables", force: :cascade do |t|
    t.datetime "paid_on"
    t.datetime "due_on"
    t.bigint "order_id"
    t.decimal "ordered_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payables_on_order_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "name"
    t.string "location"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
  end

end
