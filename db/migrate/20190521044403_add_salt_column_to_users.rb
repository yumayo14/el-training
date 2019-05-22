# frozen_string_literal: true

class AddSaltColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :salt, :string, null: false, unique: true, comment: 'パスワードハッシュ化の際に用いるデータ'
  end
end
