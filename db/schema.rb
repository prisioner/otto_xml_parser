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

ActiveRecord::Schema.define(version: 2019_12_01_181504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_files", force: :cascade do |t|
    t.string "file_guid"
    t.string "batch_guid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_parcel_items", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "parcel_id", null: false
    t.integer "quantity"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_invoice_parcel_items_on_invoice_id"
    t.index ["parcel_id"], name: "index_invoice_parcel_items_on_parcel_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "operation_number"
    t.string "operation_date"
    t.string "company_code"
    t.bigint "batch_file_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["batch_file_id"], name: "index_invoices_on_batch_file_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "invoice_parcel_items", "invoices"
  add_foreign_key "invoice_parcel_items", "parcels"
  add_foreign_key "invoices", "batch_files"
end
