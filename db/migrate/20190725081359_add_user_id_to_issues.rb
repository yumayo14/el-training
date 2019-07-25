# frozen_string_literal: true

class AddUserIdToIssues < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :user, foreign_key: true, on_delete: :cascade, comment: '「問題」を投稿したユーザーのidと紐づけられる。投稿したユーザーが削除された場合、そのユーザーが投稿した「問題」も削除される'
  end
end
