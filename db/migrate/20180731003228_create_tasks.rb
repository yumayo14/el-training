# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, index: true, null: false
      t.integer :importance, default: 0
      t.date :dead_line_on
      t.integer :status, index: true, default: 0
      t.text :detail
      t.timestamps
    end
  end
end
