# frozen_string_literal: true

class AddTasksUseridComment < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :user_id, :bigint, comment: 'タスクを投稿したユーザーのidと紐づけられる。投稿したユーザーが削除された場合、そのユーザーが投稿したタスクも削除される'
  end

  def down
    change_column :tasks, :user_id, :bigint
  end
end
