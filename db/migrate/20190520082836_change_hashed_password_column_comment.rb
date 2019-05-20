# frozen_string_literal: true

class ChangeHashedPasswordColumnComment < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :hashed_password, :string, null: false, comment: 'ハッシュ化されたユーザーのパスワード'
  end

  def down
    change_column :users, :hashed_password, :string, null: false, comment: 'ユーザーのパスワード'
  end
end
