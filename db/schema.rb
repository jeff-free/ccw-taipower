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

ActiveRecord::Schema.define(version: 2018_11_25_061503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "expenditures", force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.integer "organization_id"
    t.datetime "approved_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "organization_name"
    t.index ["approved_date"], name: "index_expenditures_on_approved_date"
    t.index ["organization_id"], name: "index_expenditures_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.integer "relative_id"
    t.integer "np_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_name"
    t.boolean "mismatch", default: false
    t.index ["mismatch"], name: "index_organizations_on_mismatch"
    t.index ["np_type"], name: "index_organizations_on_np_type"
    t.index ["relative_id"], name: "index_organizations_on_relative_id"
  end

  create_table "relatives", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.integer "representative_id"
    t.integer "kinship_type", default: 0
    t.string "kinship_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kinship_type"], name: "index_relatives_on_kinship_type"
    t.index ["representative_id"], name: "index_relatives_on_representative_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.string "name"
    t.integer "party"
    t.integer "job_type"
    t.string "job_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_type"], name: "index_representatives_on_job_type"
    t.index ["party"], name: "index_representatives_on_party"
  end

end
