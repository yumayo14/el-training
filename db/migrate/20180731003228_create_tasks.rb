class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.integer :importance, default: 0,
      t.date :dead_line_on
      t.integer :status, default: 0
      t.text :detail
      t.timestamps
    end
  end
end
