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

ActiveRecord::Schema.define(version: 20170809235954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "form1", id: false, force: :cascade do |t|
    t.integer "id",                   default: "nextval('form1_id_seq'::regclass)", null: false
    t.string  "email",    limit: 255
    t.string  "zip_code", limit: 255
  end

  create_table "form2", id: false, force: :cascade do |t|
    t.integer "id",                        default: "nextval('form2_id_seq'::regclass)", null: false
    t.string  "full_name",     limit: 255
    t.string  "business_name", limit: 255
    t.string  "email",         limit: 255
    t.text    "website"
    t.string  "phone_number",  limit: 255
    t.string  "zip_code",      limit: 255
    t.string  "delivery",      limit: 255
  end

  create_table "menu_item_translations", force: :cascade do |t|
    t.integer  "menu_item_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "description"
  end

  add_index "menu_item_translations", ["locale"], name: "index_menu_item_translations_on_locale", using: :btree
  add_index "menu_item_translations", ["menu_item_id"], name: "index_menu_item_translations_on_menu_item_id", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "price",              precision: 8, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "menu_translations", force: :cascade do |t|
    t.integer  "menu_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "menu_translations", ["locale"], name: "index_menu_translations_on_locale", using: :btree
  add_index "menu_translations", ["menu_id"], name: "index_menu_translations_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "option_group_translations", force: :cascade do |t|
    t.integer  "option_group_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  add_index "option_group_translations", ["locale"], name: "index_option_group_translations_on_locale", using: :btree
  add_index "option_group_translations", ["option_group_id"], name: "index_option_group_translations_on_option_group_id", using: :btree

  create_table "option_groups", force: :cascade do |t|
    t.integer  "menu_item_id"
    t.string   "name"
    t.string   "group_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "option_groups", ["menu_item_id"], name: "index_option_groups_on_menu_item_id", using: :btree

  create_table "option_items", force: :cascade do |t|
    t.integer  "order_item_id"
    t.integer  "option_id"
    t.string   "name"
    t.decimal  "total_price",   precision: 10, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "option_translations", force: :cascade do |t|
    t.integer  "option_id",  null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "option_translations", ["locale"], name: "index_option_translations_on_locale", using: :btree
  add_index "option_translations", ["option_id"], name: "index_option_translations_on_option_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",           precision: 8, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "option_group_id"
  end

  add_index "options", ["option_group_id"], name: "index_options_on_option_group_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "menu_item_id"
    t.decimal  "total_price",  precision: 10, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "order_items", ["menu_item_id"], name: "index_order_items_on_menu_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status"
    t.string   "delivery_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "postal_code"
    t.datetime "delivery_time"
    t.text     "delivery_instructions"
    t.decimal  "total_price",           precision: 10, scale: 2
    t.integer  "restaurant_id"
    t.string   "transaction_id"
    t.decimal  "total_to_restaurant",   precision: 5,  scale: 2
  end

  add_index "orders", ["restaurant_id"], name: "index_orders_on_restaurant_id", using: :btree

  create_table "restaurant_translations", force: :cascade do |t|
    t.integer  "restaurant_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.string   "food_type"
    t.string   "schedule_info"
  end

  add_index "restaurant_translations", ["locale"], name: "index_restaurant_translations_on_locale", using: :btree
  add_index "restaurant_translations", ["restaurant_id"], name: "index_restaurant_translations_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "food_type"
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.integer  "radius",                                          default: 0
    t.decimal  "min_order",                                       default: 0.0,                   null: false
    t.decimal  "delivery_fee",                                    default: 15.0
    t.integer  "avg_delivery_time",                               default: 30
    t.decimal  "fee",                     precision: 8, scale: 2, default: 0.05
    t.boolean  "available",                                       default: false
    t.integer  "user_id"
    t.string   "pdf_file_1_file_name"
    t.string   "pdf_file_1_content_type"
    t.integer  "pdf_file_1_file_size"
    t.datetime "pdf_file_1_updated_at"
    t.string   "pdf_file_2_file_name"
    t.string   "pdf_file_2_content_type"
    t.integer  "pdf_file_2_file_size"
    t.datetime "pdf_file_2_updated_at"
    t.string   "pdf_file_3_file_name"
    t.string   "pdf_file_3_content_type"
    t.integer  "pdf_file_3_file_size"
    t.datetime "pdf_file_3_updated_at"
    t.string   "pdf_file_4_file_name"
    t.string   "pdf_file_4_content_type"
    t.integer  "pdf_file_4_file_size"
    t.datetime "pdf_file_4_updated_at"
    t.time     "hours_open",                                      default: '2000-01-01 10:00:00'
    t.time     "hours_close",                                     default: '2000-01-01 18:00:00'
    t.string   "schedule_info"
  end

  add_index "restaurants", ["user_id"], name: "index_restaurants_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stripe_customer_id"
    t.string   "last4"
    t.string   "stripe_uid"
    t.string   "stripe_access_code"
    t.string   "stripe_publishable_key"
    t.string   "name",                   default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end