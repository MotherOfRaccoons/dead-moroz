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

ActiveRecord::Schema.define(version: 2021_02_04_140333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessments", force: :cascade do |t|
    t.integer "value", limit: 2, null: false
    t.text "comment"
    t.bigint "author_id"
    t.bigint "target_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id", "target_id"], name: "index_assessments_on_author_id_and_target_id", unique: true
    t.index ["author_id"], name: "index_assessments_on_author_id"
    t.index ["target_id"], name: "index_assessments_on_target_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "recipient_id", null: false
    t.bigint "added_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "selected", default: false
    t.index ["added_by_id"], name: "index_gifts_on_added_by_id"
    t.index ["recipient_id"], name: "index_gifts_on_recipient_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.bigint "gift_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gift_id"], name: "index_images_on_gift_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "token"
    t.integer "status", limit: 2, default: 0, null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_invitations_on_email", unique: true
    t.index ["token"], name: "index_invitations_on_token", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "reviewee_id", null: false
    t.bigint "reviewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_reviews_on_discarded_at"
    t.index ["reviewee_id"], name: "index_reviews_on_reviewee_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 25, null: false
    t.string "last_name", limit: 25, null: false
    t.string "middle_name", limit: 25
    t.date "birthdate"
    t.integer "gender"
    t.string "address", limit: 100, null: false
    t.text "behavior"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.integer "role", limit: 2, default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assessments", "users", column: "author_id"
  add_foreign_key "assessments", "users", column: "target_id"
  add_foreign_key "gifts", "users", column: "added_by_id"
  add_foreign_key "gifts", "users", column: "recipient_id"
  add_foreign_key "images", "gifts"
  add_foreign_key "reviews", "users", column: "reviewee_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
end
