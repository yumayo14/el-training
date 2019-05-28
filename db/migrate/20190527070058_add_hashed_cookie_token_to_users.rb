# frozen_string_literal: true

class AddHashedCookieTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hashed_cookie_token, :string, comment: 'cookiesに保存されるトークンを暗号化したもの'
  end
end
