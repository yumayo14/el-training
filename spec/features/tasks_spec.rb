require 'rails_helper'

RSpec.feature"Tasks",type: :feature do
  given(:task) { FactoryBot.create(:task) }
  given(:task_1) { FactoryBot.create(:task) }
  background do
    visit tasks_path
  end

  describe "タスクの一覧表示" do
    before do
      expect(page).to have_content @tasks
    end
    it "indexページに投稿されたタスクの一覧が表示される" do
      all('task').each do |task|
        expect(page).to have_content task.title
        expect(page).to have_content task.importance
        expect(page).to have_content task.status
        expect(page).to have_content task.dead_line_on
        expect(page).to have_content task.detail
      end
    end
  end

  describe "タスクの投稿" do
    context "必要な値を入力している場合" do
      before do
        click_link "タスクの投稿"
        fill_in 'task_title', with: 'feature_test'
        select '高', from: 'task_importance'
        select '2018', from: 'task_dead_line_on_1i'
        select '8', from: 'task_dead_line_on_2i'
        select '2', from: 'task_dead_line_on_3i'
        select '着手', from: 'task_status'
        fill_in 'task_detail', with: 'feature_specのテストです'
        click_button '新しいタスクを追加'
      end
      it "新しいタスクの投稿に成功" do
        expect(page).to have_content "新しいタスクが作成されました"
      end
    end
  end

  describe "個別のタスクに対して行う操作" do
    background do
      visit task_path(task.id)
    end
    describe "タスクの編集と更新" do
      context "必要な値を入力している場合" do
        before do
          click_link "編集"
          fill_in 'task_title', with: 'タスクの更新'
          click_button '新しいタスクを追加'
        end
        it "作成したタスクの更新する" do
          expect(page).to have_content "タスクの内容が変更されました"
        end
      end
    end

    describe "タスクの削除" do
      before do
        click_link "削除"
      end
      it "作成したタスクを削除" do
        expect(page).to have_content "タスクを削除しました"
      end
    end
  end
end