# frozen_string_literal: true

class ChangeHashedCookieTokenColumnOptions < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :hashed_cookie_token, :string, after: :hashed_password, comment: 'ユーザーのログイン時に使用されるcookiesトークンを暗号化したもの'
  end

  def down
    change_column :users, :hashed_cookie_token, :string, comment: 'cookiesに保存されるトークンを暗号化したもの'
  end
end
