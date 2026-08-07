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

ActiveRecord::Schema[8.1].define(version: 2026_08_05_120324) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "property_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["property_id"], name: "index_favorites_on_property_id"
    t.index ["user_id", "property_id"], name: "index_favorites_on_user_id_and_property_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.text "message"
    t.string "name"
    t.bigint "property_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["property_id"], name: "index_inquiries_on_property_id"
    t.index ["user_id"], name: "index_inquiries_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "exp"
    t.string "jti"
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "properties", force: :cascade do |t|
    t.integer "area"
    t.integer "bathrooms"
    t.integer "bedrooms"
    t.string "city"
    t.datetime "created_at", null: false
    t.text "description"
    t.float "latitude"
    t.text "location"
    t.float "longitude"
    t.integer "marla_type"
    t.decimal "price"
    t.integer "property_type"
    t.integer "purpose"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_url"
    t.bigint "property_id", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_images_on_property_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "cnic"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "phone"
    t.string "profile_image"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "properties"
  add_foreign_key "favorites", "users"
  add_foreign_key "inquiries", "properties"
  add_foreign_key "inquiries", "users"
  add_foreign_key "properties", "users"
  add_foreign_key "property_images", "properties"
end
