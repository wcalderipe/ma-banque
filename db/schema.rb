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

ActiveRecord::Schema.define(version: 2020_07_01_062715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_events", force: :cascade do |t|
    t.string "type", null: false
    t.integer "account_id", null: false
    t.text "data", null: false
    t.text "metadata", null: false
    t.datetime "created_at", null: false
    t.index ["account_id"], name: "index_account_events_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "status", default: "pending"
    t.decimal "balance", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_events", force: :cascade do |t|
    t.string "type", null: false
    t.integer "transaction_id", null: false
    t.text "data", null: false
    t.text "metadata", null: false
    t.datetime "created_at", null: false
    t.index ["transaction_id"], name: "index_transaction_events_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "balance", default: "0.0"
    t.string "kind"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  add_foreign_key "transactions", "accounts"
end
