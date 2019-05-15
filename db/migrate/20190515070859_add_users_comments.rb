# frozen_string_literal: true

class AddUsersComments < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :name, :string, null: false, comment: 'ユーザーの本名'
    change_column :users, :accountid, :string,  default: 0, null: false, unique: true, comment: 'ユーザーのアカウントID、ユーザー固有の値'
    change_column :users, :password, :string, null: false, comment: 'ユーザーのパスワード'
  end

  def down
    change_column :users, :name, :string, null: false
    change_column :users, :accountid, :string,  default: 0, null: false, unique: true
    change_column :users, :password, :string, null: false
  end
end
