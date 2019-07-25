# frozen_string_literal: true

class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :title, index: true, null: false
      t.integer :status, index: true, default: 0
      t.date :dead_line_on, null: false
      t.timestamps
    end
  end
end
