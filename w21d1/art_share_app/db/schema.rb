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

ActiveRecord::Schema[7.0].define(version: 2023_01_19_220053) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "art_listings", force: :cascade do |t|
    t.bigint "artwork_id"
    t.bigint "collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id", "collection_id"], name: "index_art_listings_on_artwork_id_and_collection_id", unique: true
    t.index ["artwork_id"], name: "index_art_listings_on_artwork_id"
    t.index ["collection_id"], name: "index_art_listings_on_collection_id"
  end

  create_table "artwork_collections", force: :cascade do |t|
    t.bigint "collector_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collector_id"], name: "index_artwork_collections_on_collector_id"
  end

  create_table "artwork_shares", force: :cascade do |t|
    t.bigint "viewer_id"
    t.bigint "artwork_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_favorited"
    t.index ["artwork_id"], name: "index_artwork_shares_on_artwork_id"
    t.index ["viewer_id", "artwork_id"], name: "index_artwork_shares_on_viewer_id_and_artwork_id", unique: true
    t.index ["viewer_id"], name: "index_artwork_shares_on_viewer_id"
  end

  create_table "artworks", force: :cascade do |t|
    t.string "title", null: false
    t.string "image_url", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_favorited"
    t.index ["artist_id", "title"], name: "index_artworks_on_artist_id_and_title", unique: true
    t.index ["artist_id"], name: "index_artworks_on_artist_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "artwork_id"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_comments_on_artwork_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "art_listings", "artwork_collections", column: "collection_id"
  add_foreign_key "art_listings", "artworks"
  add_foreign_key "artwork_collections", "users", column: "collector_id"
  add_foreign_key "artwork_shares", "artworks"
  add_foreign_key "artwork_shares", "users", column: "viewer_id"
  add_foreign_key "artworks", "users", column: "artist_id"
  add_foreign_key "comments", "artworks"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "users"
end
