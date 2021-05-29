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

ActiveRecord::Schema.define(version: 2020_09_14_210426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_sensors", force: :cascade do |t|
    t.string "sensor_name"
    t.string "contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assigned_sensors", force: :cascade do |t|
    t.bigint "contract_id"
    t.string "sensor_name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_assigned_sensors_on_contract_id"
    t.index ["sensor_name"], name: "index_assigned_sensors_on_sensor_name"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "contract_id"
    t.string "name"
    t.integer "fvalue"
    t.boolean "alarm"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_date"
    t.index ["contract_id"], name: "index_contracts_on_contract_id"
  end

  create_table "data_owners", force: :cascade do |t|
    t.bigint "group_id"
    t.text "dataset_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "memeber"
    t.index ["group_id"], name: "index_data_owners_on_group_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["user_id"], name: "index_group_members_on_user_id"
  end

  create_table "group_roles", force: :cascade do |t|
    t.bigint "group_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_roles_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaf_failure_types", force: :cascade do |t|
    t.string "activity"
    t.string "failure"
    t.string "cause"
    t.boolean "admin_approval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaf_failures", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.string "description"
    t.string "activity"
    t.string "failure"
    t.string "cause"
    t.boolean "recoverable"
    t.string "measures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "error_datetime"
    t.bigint "leaf_failure_type_id"
    t.index ["activity"], name: "index_leaf_failures_on_activity"
    t.index ["leaf_failure_type_id"], name: "index_leaf_failures_on_leaf_failure_type_id"
    t.index ["status"], name: "index_leaf_failures_on_status"
    t.index ["user_id"], name: "index_leaf_failures_on_user_id"
  end

  create_table "leaf_measure_types", force: :cascade do |t|
    t.string "name"
    t.integer "success_percent"
    t.boolean "admin_approval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "leaf_failure_type_id"
    t.index ["leaf_failure_type_id"], name: "index_leaf_measure_types_on_leaf_failure_type_id"
  end

  create_table "leaf_measures", force: :cascade do |t|
    t.bigint "leaf_measure_type_id"
    t.bigint "leaf_failure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leaf_failure_id"], name: "index_leaf_measures_on_leaf_failure_id"
    t.index ["leaf_measure_type_id"], name: "index_leaf_measures_on_leaf_measure_type_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sensor_values", force: :cascade do |t|
    t.string "sensor_name"
    t.integer "sensor_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.integer "site_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "data_owners", "groups"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "group_roles", "groups"
  add_foreign_key "leaf_failures", "leaf_failure_types"
  add_foreign_key "leaf_failures", "users"
  add_foreign_key "leaf_measure_types", "leaf_failure_types"
  add_foreign_key "leaf_measures", "leaf_failures"
  add_foreign_key "leaf_measures", "leaf_measure_types"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
end
