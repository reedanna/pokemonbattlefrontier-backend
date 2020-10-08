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

ActiveRecord::Schema.define(version: 11) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.string "effect"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.bigint "type_id", null: false
    t.string "category"
    t.integer "BP"
    t.string "other_effects"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type_id"], name: "index_moves_on_type_id"
  end

  create_table "natures", force: :cascade do |t|
    t.string "name"
    t.string "stat_lowered"
    t.string "stat_raised"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pokemon_moves", force: :cascade do |t|
    t.bigint "move_id", null: false
    t.bigint "pokemon_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["move_id"], name: "index_pokemon_moves_on_move_id"
    t.index ["pokemon_id"], name: "index_pokemon_moves_on_pokemon_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.bigint "ability_id", null: false
    t.bigint "nature_id", null: false
    t.bigint "user_id", null: false
    t.bigint "species_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ability_id"], name: "index_pokemons_on_ability_id"
    t.index ["nature_id"], name: "index_pokemons_on_nature_id"
    t.index ["species_id"], name: "index_pokemons_on_species_id"
    t.index ["user_id"], name: "index_pokemons_on_user_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.integer "HP"
    t.integer "attack"
    t.integer "special_attack"
    t.integer "defense"
    t.integer "special_defense"
    t.integer "speed"
    t.string "sprite_url"
    t.string "icon_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "species_abilities", force: :cascade do |t|
    t.bigint "ability_id", null: false
    t.bigint "species_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ability_id"], name: "index_species_abilities_on_ability_id"
    t.index ["species_id"], name: "index_species_abilities_on_species_id"
  end

  create_table "species_moves", force: :cascade do |t|
    t.bigint "move_id", null: false
    t.bigint "species_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["move_id"], name: "index_species_moves_on_move_id"
    t.index ["species_id"], name: "index_species_moves_on_species_id"
  end

  create_table "species_types", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.bigint "species_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["species_id"], name: "index_species_types_on_species_id"
    t.index ["type_id"], name: "index_species_types_on_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.string "strong_against", array: true
    t.string "weak_against", array: true
    t.string "no_effect_against", array: true
    t.string "resists", array: true
    t.string "weak_to", array: true
    t.string "immune_to", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "moves", "types"
  add_foreign_key "pokemon_moves", "moves"
  add_foreign_key "pokemon_moves", "pokemons"
  add_foreign_key "pokemons", "abilities"
  add_foreign_key "pokemons", "natures"
  add_foreign_key "pokemons", "species"
  add_foreign_key "pokemons", "users"
  add_foreign_key "species_abilities", "abilities"
  add_foreign_key "species_abilities", "species"
  add_foreign_key "species_moves", "moves"
  add_foreign_key "species_moves", "species"
  add_foreign_key "species_types", "species"
  add_foreign_key "species_types", "types"
end
