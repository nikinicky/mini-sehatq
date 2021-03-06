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

ActiveRecord::Schema.define(version: 2020_08_16_101753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer "doctor_id"
    t.integer "user_id"
    t.integer "schedule_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["schedule_id"], name: "index_appointments_on_schedule_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "doctor_informations", force: :cascade do |t|
    t.string "description"
    t.integer "hospital_ids", default: [], array: true
    t.integer "speciality_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "doctor_id"
    t.index ["doctor_id"], name: "index_doctor_informations_on_doctor_id"
  end

  create_table "doctor_schedules", force: :cascade do |t|
    t.integer "doctor_id"
    t.integer "hospital_id"
    t.date "date"
    t.string "start_hour"
    t.string "end_hour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_doctor_schedules_on_doctor_id"
    t.index ["hospital_id"], name: "index_doctor_schedules_on_hospital_id"
  end

  create_table "doctor_specialities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hospital_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, default: "2020-08-15 09:15:12", null: false
    t.datetime "updated_at", precision: 6, default: "2020-08-15 09:15:12", null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name", null: false
    t.string "district", null: false
    t.string "address"
    t.string "open_hours"
    t.boolean "support_emergency", default: false
    t.bigint "hospital_type_id"
    t.datetime "created_at", precision: 6, default: "2020-08-15 09:02:13", null: false
    t.datetime "updated_at", precision: 6, default: "2020-08-15 09:02:13", null: false
    t.index ["hospital_type_id"], name: "index_hospitals_on_hospital_type_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.integer "appointment_id"
    t.string "payment_type"
    t.string "notes"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "gender"
    t.date "birthday"
    t.boolean "is_doctor", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
