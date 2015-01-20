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

ActiveRecord::Schema.define(version: 20150112072219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "blog_posts", force: true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colour_groups", force: true do |t|
    t.integer  "product_id"
    t.text     "colour_ids", default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enquiries", force: true do |t|
    t.string   "name"
    t.string   "email_address"
    t.string   "mobile_number"
    t.text     "message"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",      default: false
  end

  create_table "images", force: true do |t|
    t.integer  "product_id"
    t.string   "cloudinary_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.integer  "price"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
    t.string   "slug"
    t.text     "description"
    t.text     "fabric_and_feel"
    t.text     "fit_and_size"
    t.text     "measurements"
    t.string   "category"
    t.integer  "price"
    t.boolean  "sold_out",        default: false
    t.integer  "position"
    t.boolean  "publish",         default: false
    t.boolean  "multiple_sizes",  default: false
  end

  create_table "purchases", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "email_address"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "post_code"
    t.string   "country"
    t.string   "name_on_card"
    t.integer  "delivery_price"
    t.string   "stripe_token"
    t.string   "last_4_digits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "voucher_code"
    t.integer  "voucher_discount_amount"
  end

  create_table "vouchers", force: true do |t|
    t.string   "code"
    t.integer  "fixed_discount_amount_in_cent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
