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

ActiveRecord::Schema.define(version: 2019_05_16_021458) do
  create_table 'tasks', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'title', null: false, comment: 'タスク名'
    t.integer 'importance', default: 0, comment: 'タスクの優先度'
    t.date 'dead_line_on', comment: 'タスクの期限'
    t.integer 'status', default: 0, comment: 'タスクの進捗'
    t.text 'detail', comment: 'タスクの詳細'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['status'], name: 'index_tasks_on_status'
    t.index ['title'], name: 'index_tasks_on_title'
    t.index ['user_id'], name: 'index_tasks_on_user_id'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'accountid', null: false
    t.string 'password', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'tasks', 'users'
end
