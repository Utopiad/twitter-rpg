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

ActiveRecord::Schema.define(version: 20161203200204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.integer  "classe_id"
    t.integer  "user_id"
    t.integer  "world_id"
    t.text     "name"
    t.integer  "total_experience"
    t.integer  "bonus_attack_min"
    t.integer  "bonus_attack_max"
    t.integer  "bonus_defense"
    t.integer  "bonus_life"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "classes", force: :cascade do |t|
    t.integer  "world_id"
    t.text     "name"
    t.integer  "base_attack_min"
    t.integer  "base_attack_max"
    t.integer  "base_defense"
    t.integer  "base_life"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "map_has_monsters", force: :cascade do |t|
    t.integer  "map_id"
    t.integer  "monster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maps", force: :cascade do |t|
    t.integer  "north_map_id"
    t.integer  "east_map_id"
    t.integer  "south_map_id"
    t.integer  "west_map_id"
    t.integer  "world_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "monsters", force: :cascade do |t|
    t.text     "name"
    t.integer  "base_min_attack"
    t.integer  "base_max_attack"
    t.integer  "base_defense"
    t.integer  "base_life"
    t.integer  "world_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "monstres", force: :cascade do |t|
    t.text     "name"
    t.integer  "base_min_attack"
    t.integer  "base_max_attack"
    t.integer  "base_defense"
    t.integer  "base_life"
    t.integer  "world_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "worlds", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
