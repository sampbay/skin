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

ActiveRecord::Schema.define(version: 20180128194356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "blacklists", force: :cascade do |t|
    t.citext   "ingredient", default: [],              array: true
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "blacklists", ["user_id"], name: "index_blacklists_on_user_id", using: :btree

  create_table "breakout_product_manuals", force: :cascade do |t|
    t.citext   "brand",        null: false
    t.citext   "product",      null: false
    t.citext   "ingredients"
    t.citext   "product_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "breakout_product_manuals", ["user_id"], name: "index_breakout_product_manuals_on_user_id", using: :btree

  create_table "breakout_products", force: :cascade do |t|
    t.citext   "product",    null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "breakout_products", ["user_id"], name: "index_breakout_products_on_user_id", using: :btree

  create_table "comedogeniclists", force: :cascade do |t|
    t.citext   "ingredient"
    t.citext   "cas"
    t.citext   "rating"
    t.citext   "fulton_1989"
    t.citext   "morris_kwan_1983"
    t.datetime "created_at",       default: '2018-03-08 04:04:48', null: false
    t.datetime "updated_at",       default: '2018-03-08 04:04:48', null: false
  end

  create_table "cosing_annex_iis", force: :cascade do |t|
    t.integer  "reference_number"
    t.citext   "chemical_name_inn"
    t.text     "cas_number"
    t.text     "ec_number"
    t.text     "regulation"
    t.text     "regulated_by"
    t.text     "other_directives_regulations"
    t.text     "sccs_opinions"
    t.citext   "chemical_iupac_name"
    t.citext   "identified_ingredients_or_substances"
    t.text     "cmr"
    t.datetime "update_date"
    t.datetime "created_at",                           default: '2018-03-08 04:04:48', null: false
    t.datetime "updated_at",                           default: '2018-03-08 04:04:48', null: false
  end

  create_table "cosings", force: :cascade do |t|
    t.integer  "COSING_Ref_No"
    t.citext   "INCI_name"
    t.citext   "INN_name"
    t.citext   "Ph_Eur_Name"
    t.text     "CAS_No"
    t.text     "EINECS_ELINCS_No"
    t.string   "Chem_IUPAC_Name_Description"
    t.string   "Restriction"
    t.string   "Function"
    t.datetime "Update_Date"
    t.datetime "created_at",                  default: '2018-03-08 04:04:48', null: false
    t.datetime "updated_at",                  default: '2018-03-08 04:04:48', null: false
  end

  create_table "favorite_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.citext   "product"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "healthcanadahotlists", force: :cascade do |t|
    t.citext   "ingredient"
    t.text     "cas"
    t.citext   "synonyms"
    t.text     "status"
    t.citext   "ingredient_original"
    t.text     "conditions_of_use"
    t.text     "maximum_concentration_permitted"
    t.text     "warnings_and_cautions"
    t.datetime "update_date"
    t.datetime "created_at",                      default: '2018-03-08 04:04:48', null: false
    t.datetime "updated_at",                      default: '2018-03-08 04:04:48', null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.citext   "name"
    t.string   "name_href"
    t.string   "overall_hazard"
    t.string   "cancer"
    t.string   "developmental"
    t.string   "allergies"
    t.string   "restrictions"
    t.string   "other_concerns"
    t.string   "animals"
    t.string   "score"
    t.citext   "synonyms",       default: [],              array: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "myproducts", force: :cascade do |t|
    t.citext   "product",    null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "myproducts", ["user_id"], name: "index_myproducts_on_user_id", using: :btree

  create_table "potential_products", force: :cascade do |t|
    t.citext   "product",    default: [],              array: true
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "potential_products", ["user_id"], name: "index_potential_products_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.citext   "brand"
    t.citext   "product"
    t.citext   "product_type"
    t.text     "claims"
    t.citext   "ingredients"
    t.citext   "img"
    t.datetime "created_at",   default: '2018-03-08 04:04:48', null: false
    t.datetime "updated_at",   default: '2018-03-08 04:04:48', null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.citext   "skin_type"
    t.citext   "ethnicity"
    t.citext   "age"
    t.citext   "concerns",   default: [],              array: true
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "recommends", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "safe_product_manuals", force: :cascade do |t|
    t.citext   "brand",        null: false
    t.citext   "product",      null: false
    t.citext   "ingredients"
    t.citext   "product_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "safe_product_manuals", ["user_id"], name: "index_safe_product_manuals_on_user_id", using: :btree

  create_table "safe_products", force: :cascade do |t|
    t.citext   "product",    null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "safe_products", ["user_id"], name: "index_safe_products_on_user_id", using: :btree

  create_table "suggests", force: :cascade do |t|
    t.string   "user"
    t.string   "brand"
    t.string   "product"
    t.string   "link"
    t.text     "ingredients"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_blacklists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "blacklist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_breakout_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "breakout_product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "user_favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favorite_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_myproducts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "myproduct_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_potential_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "potential_product_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_safe_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "safe_product_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.citext   "first_name"
    t.citext   "last_name"
    t.citext   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
