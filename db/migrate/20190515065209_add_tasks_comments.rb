# frozen_string_literal: true

class AddTasksComments < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :title, :string, index: true, null: false, comment: 'タスク名'
    change_column :tasks, :importance, :integer,  default: 0, comment: 'タスクの優先度'
    change_column :tasks, :dead_line_on, :date, comment: 'タスクの期限'
    change_column :tasks, :status, :integer, index: true, default: 0, comment: 'タスクの進捗'
    change_column :tasks, :detail, :text, comment: 'タスクの詳細'
  end

  def down
    change_column :tasks, :title, :string, index: true, null: false
    change_column :tasks, :importance, :integer,  default: 0
    change_column :tasks, :dead_line_on, :date
    change_column :tasks, :status, :integer, index: true, default: 0
    change_column :tasks, :detail, :text
  end
end
