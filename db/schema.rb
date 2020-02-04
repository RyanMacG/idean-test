# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_04_152020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversion_rates", force: :cascade do |t|
    t.float "rate"
    t.bigint "from_currency_id", null: false
    t.bigint "to_currency_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["from_currency_id"], name: "index_conversion_rates_on_from_currency_id"
    t.index ["to_currency_id"], name: "index_conversion_rates_on_to_currency_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "short_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["short_code"], name: "index_currencies_on_short_code", unique: true
  end

  create_table "denominations", force: :cascade do |t|
    t.integer "amount"
    t.integer "stock"
    t.bigint "currency_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_denominations_on_currency_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "from_currency_id", null: false
    t.bigint "to_currency_id", null: false
    t.float "conversion_rate"
    t.integer "amount_purchased"
    t.text "denominations", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["from_currency_id"], name: "index_orders_on_from_currency_id"
    t.index ["to_currency_id"], name: "index_orders_on_to_currency_id"
  end

  add_foreign_key "conversion_rates", "currencies", column: "from_currency_id"
  add_foreign_key "conversion_rates", "currencies", column: "to_currency_id"
  add_foreign_key "denominations", "currencies"
  add_foreign_key "orders", "currencies", column: "from_currency_id"
  add_foreign_key "orders", "currencies", column: "to_currency_id"
end
