# frozen_string_literal: true

class ChangeUsersPasswordColumnToHashedPasswordColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password, :hashed_password
  end
end
