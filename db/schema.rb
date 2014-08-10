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

ActiveRecord::Schema.define(version: 20140810170448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "actores", force: true do |t|
    t.string   "nombre",                        null: false
    t.string   "acronimo"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_logo_url"
    t.integer  "iniciativas_count", default: 0
  end

  add_index "actores", ["nombre"], name: "index_actores_on_nombre", using: :btree

  create_table "grupos_preguntas", force: true do |t|
    t.string  "title"
    t.integer "kind"
  end

  add_index "grupos_preguntas", ["kind"], name: "index_grupos_preguntas_on_kind", using: :btree

  create_table "iniciativas", force: true do |t|
    t.integer  "actor_id",    null: false
    t.string   "nombre",      null: false
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "iniciativas", ["actor_id"], name: "index_iniciativas_on_actor_id", using: :btree

  create_table "pregunta_options", force: true do |t|
    t.string  "answer"
    t.integer "pregunta_id", null: false
  end

  add_index "pregunta_options", ["pregunta_id"], name: "index_pregunta_options_on_pregunta_id", using: :btree

  create_table "preguntas", force: true do |t|
    t.string  "title",                                    null: false
    t.boolean "allow_other",              default: false
    t.integer "other_pregunta_option_id"
    t.integer "grupo_preguntas_id"
    t.integer "kind",                     default: 0
    t.integer "parent_id"
  end

  add_index "preguntas", ["grupo_preguntas_id"], name: "index_preguntas_on_grupo_preguntas_id", using: :btree
  add_index "preguntas", ["parent_id"], name: "index_preguntas_on_parent_id", using: :btree

  create_table "respuesta_preguntas", force: true do |t|
    t.integer "pregunta_id"
    t.integer "respuesta_id"
    t.text    "answer"
  end

  add_index "respuesta_preguntas", ["pregunta_id", "respuesta_id"], name: "index_respuesta_preguntas_on_pregunta_id_and_respuesta_id", using: :btree

  create_table "respuestas", force: true do |t|
    t.integer  "user_id"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "respuestas", ["user_id", "actor_id"], name: "index_respuestas_on_user_id_and_actor_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "nombres"
    t.boolean  "admin"
    t.integer  "actor_id"
    t.string   "invitation_token"
    t.datetime "invitation_token_expires_at"
  end

  add_index "users", ["actor_id"], name: "index_users_on_actor_id", using: :btree
  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
