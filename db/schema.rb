# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_161_218_030_427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'chapters', force: :cascade do |t|
    t.string   'title'
    t.text     'description'
    t.string   'image'
    t.integer  'world_id'
    t.integer  'active', default: 1
    t.datetime 'created_at',              null: false
    t.datetime 'updated_at',              null: false
  end

  create_table 'character_types', force: :cascade do |t|
    t.text     'name'
    t.integer  'world_id'
    t.integer  'attack_min', default: 0
    t.integer  'attack_max', default: 0
    t.integer  'armor',      default: 0
    t.integer  'life',       default: 0
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  create_table 'characters', force: :cascade do |t|
    t.integer  'character_type_id'
    t.integer  'user_id'
    t.integer  'world_id'
    t.text     'name'
    t.text     'slug'
    t.string   'image'
    t.integer  'total_experience',  default: 0
    t.integer  'bonus_attack',      default: 0
    t.integer  'bonus_armor',       default: 0
    t.integer  'bonus_life',        default: 0
    t.integer  'malus_life',        default: 0
    t.integer  'is_narrator',       default: 0
    t.integer  'has_played',        default: 0
    t.datetime 'created_at',                    null: false
    t.datetime 'updated_at',                    null: false
  end

  create_table 'event_monsters', force: :cascade do |t|
    t.integer  'monster_id'
    t.integer  'event_id'
    t.integer  'has_played',   default: 0
    t.integer  'bonus_attack', default: 0
    t.integer  'bonus_life',   default: 0
    t.integer  'bonus_armor',  default: 0
    t.integer  'malus_life',   default: 0
    t.string   'name'
    t.string   'slug'
    t.datetime 'created_at',               null: false
    t.datetime 'updated_at',               null: false
  end

  create_table 'events', force: :cascade do |t|
    t.string   'title'
    t.text     'description'
    t.string   'image'
    t.integer  'chapter_id'
    t.integer  'active', default: 1
    t.datetime 'created_at',              null: false
    t.datetime 'updated_at',              null: false
  end

  create_table 'fights', force: :cascade do |t|
    t.string   'attacker_type'
    t.integer  'attacker_id'
    t.string   'defender_type'
    t.integer  'defender_id'
    t.integer  'hit'
    t.datetime 'created_at',    null: false
    t.datetime 'updated_at',    null: false
    t.index %w[attacker_type attacker_id], name: 'index_fights_on_attacker_type_and_attacker_id', using: :btree
    t.index %w[defender_type defender_id], name: 'index_fights_on_defender_type_and_defender_id', using: :btree
  end

  create_table 'inventories', force: :cascade do |t|
    t.integer  'character_id'
    t.integer  'stuff_id'
    t.integer  'used',         default: 0
    t.integer  'equiped',      default: 0
    t.string   'name'
    t.string   'slug'
    t.datetime 'created_at',               null: false
    t.datetime 'updated_at',               null: false
  end

  create_table 'messages', force: :cascade do |t|
    t.integer  'character_id'
    t.integer  'event_id'
    t.text     'message'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  create_table 'monsters', force: :cascade do |t|
    t.integer  'world_id'
    t.text     'name'
    t.string   'image'
    t.integer  'attack_min', default: 0
    t.integer  'attack_max', default: 0
    t.integer  'armor',      default: 0
    t.integer  'life',       default: 0
    t.integer  'malus_life', default: 0
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  create_table 'rewards', force: :cascade do |t|
    t.integer  'quantity', default: 0
    t.integer  'event_id'
    t.integer  'stuff_id'
    t.string   'name'
    t.string   'slug'
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  create_table 'stuffs', force: :cascade do |t|
    t.integer  'world_id'
    t.integer  'bonus_attack'
    t.integer  'bonus_armor'
    t.integer  'bonus_life'
    t.string   'name'
    t.string   'slug'
    t.string   'image'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  create_table 'turns', force: :cascade do |t|
    t.integer  'event_id'
    t.integer  'finished', default: 0
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.string   'name'
    t.string   'image'
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  end

  create_table 'worlds', force: :cascade do |t|
    t.integer  'user_id'
    t.integer  'character_id'
    t.string   'name'
    t.text     'description'
    t.string   'image'
    t.integer  'public'
    t.integer  'max_character_count'
    t.datetime 'created_at',          null: false
    t.datetime 'updated_at',          null: false
  end
end
