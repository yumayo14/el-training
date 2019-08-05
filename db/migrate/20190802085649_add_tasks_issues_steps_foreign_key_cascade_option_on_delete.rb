# frozen_string_literal: true

class AddTasksIssuesStepsForeignKeyCascadeOptionOnDelete < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key :tasks, :users
    remove_foreign_key :issues, :users
    remove_foreign_key :steps, :issues
    add_foreign_key :tasks, :users, on_delete: :cascade
    add_foreign_key :issues, :users, on_delete: :cascade
    add_foreign_key :steps, :issues, on_delete: :cascade
  end

  def down
    remove_foreign_key :tasks, :users
    remove_foreign_key :issues, :users
    remove_foreign_key :steps, :issues
    add_foreign_key :tasks, :users
    add_foreign_key :issues, :users
    add_foreign_key :steps, :issues
  end
end
