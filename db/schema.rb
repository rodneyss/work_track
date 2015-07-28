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

ActiveRecord::Schema.define(version: 20150727130638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "address"
    t.text     "notes"
    t.datetime "start"
    t.datetime "finish"
    t.integer  "seconds",    default: 0
    t.text     "comments"
    t.integer  "client_id"
    t.integer  "company_id"
    t.boolean  "completed",  default: false
    t.boolean  "paid",       default: false
    t.string   "photo1"
    t.string   "photo2"
    t.string   "photo3"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "reference"
    t.string   "onsite"
    t.float    "amount"
  end

  create_table "jobs_payslips", id: false, force: :cascade do |t|
    t.integer "job_id"
    t.integer "payslip_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.boolean  "paid",       default: false
    t.datetime "start",      default: '2015-07-28 10:32:30'
    t.datetime "finish"
    t.boolean  "finalized",  default: false
    t.integer  "user_id"
    t.integer  "seconds",    default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "address"
    t.integer  "company_id"
    t.boolean  "boss",            default: false
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
