# frozen_string_literal: true

class AddIssueIdToSteps < ActiveRecord::Migration[5.2]
  def change
    add_reference :steps, :issue, foreign_key: true, on_delete: :cascade, comment: '「問題」のidと紐づけられる。「問題」が削除された場合、その「問題」に投稿された「ステップ」も削除される'
  end
end
