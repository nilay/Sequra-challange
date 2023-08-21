# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_21_060156) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.date "disbursement_date", null: false
    t.string "reference_number"
    t.decimal "fee", precision: 10, scale: 2
    t.decimal "left_over_fee", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_number"], name: "index_disbursements_on_reference_number", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "reference", null: false
    t.string "email", null: false
    t.date "live_on"
    t.integer "disbursement_frequency", null: false
    t.decimal "minimum_monthly_fee", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference"], name: "index_merchants_on_reference", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "merchant_id", null: false
    t.decimal "amount", precision: 10, scale: 2
    t.date "created_at", null: false
    t.boolean "disbursed", default: false
    t.index ["merchant_id", "created_at", "disbursed"], name: "index_orders_on_merchant_id_and_created_at_and_disbursed"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
  end

  create_table "orders_disbursements", force: :cascade do |t|
    t.bigint "disbursement_id", null: false
    t.bigint "order_id", null: false
    t.decimal "fee", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_id"], name: "index_orders_disbursements_on_disbursement_id"
    t.index ["order_id"], name: "index_orders_disbursements_on_order_id"
  end

  add_foreign_key "orders", "merchants"
  add_foreign_key "orders_disbursements", "disbursements"
  add_foreign_key "orders_disbursements", "orders"
end
