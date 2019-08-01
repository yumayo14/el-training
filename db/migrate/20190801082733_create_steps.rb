# frozen_string_literal: true

class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.string :title, null: false
      t.references 
      t.timestamps
    end
  end
end
