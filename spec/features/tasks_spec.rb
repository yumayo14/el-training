require 'rails_helper'

RSpec.feature"Tasks",type: :feature do
  given(:task) { FactoryBot.create(:task) }
  describe "タスクの一覧に対する操作" do
    before do
      FactoryBot.create(:task, title: "2番目", importance: 2, status: 0, dead_line_on: "2020-07-24", created_at: "2020/07/24 16:00::55")
      FactoryBot.create(:task, title: "1番目", importance: 1, status: 1, dead_line_on: "2020-08-09", created_at: "2020/08/09 09:00:00")
      visit tasks_path
    end

    describe "タスクの一覧表示" do
      it "indexページに投稿されたタスクの一覧が表示される" do
        all('table tr.task').each do
          expect(page).to have_content "2番目"
          expect(page).to have_content "高"
          expect(page).to have_content "未着手"
          expect(page).to have_content "2020-07-24"
          expect(page).to have_content "infinity_task..."
          expect(page).to have_content "1番目"
          expect(page).to have_content "中"
          expect(page).to have_content "着手"
          expect(page).to have_content "2020-08-09"
          expect(page).to have_content "infinity_task..."
        end
      end
      it "ページ遷移後、投稿日が新しい順に並んでいる", js: true do
        within all('table tr.tasks')[0] do
          # スクリーンショットをとって確認する方法、やって見る
          expect(find('th.created_day')).to have_content "2020/08/09"
        end
        within all('table tr.tasks')[1] do
          expect(find('th.created_day')).to have_content  "2020/07/24"
        end
      end
    end

    describe "タスクの並び替え", js: true do
      context "投稿日が新しい順" do
        before do
          click_button '投稿日順'
        end
        it "投稿日が昔順に並び替える" do
          within all('table tr.tasks')[0] do
            expect(find('th.created_day')).to have_content "2020/08/09"
          end
          within all('table tr.tasks')[1] do
            expect(find('th.created_day')).to have_content  "2020/07/24"
          end
        end
      end

      context "投稿日が古い順" do
        before do
          click_button '投稿日順'
          click_button '投稿日順'
        end
        it "投稿日が昔新しい順に並び替える" do
          within all('table tr.tasks')[0] do
            expect(find('th.created_day')).to have_content "2020/07/24"
          end
          within all('table tr.tasks')[1] do
            expect(find('th.created_day')).to have_content  "2020/08/09"
          end
        end
      end

      context "期限日が近い順" do
        before do
          click_button '期限日順'
        end
        it "期限が近い順に並び替える" do
          within all('table tr.tasks')[0] do
            expect(find('th.dead_line_on')).to have_content "2020-07-24"
          end
          within all('table tr.tasks')[1] do
            expect(find('th.dead_line_on')).to have_content  "2020-08-09"
          end
        end
      end
      context "期限日が遠いの順" do
        before do
          click_button '期限日順'
          click_button '期限日順'
        end
        it "期限が遠い順に並び替える" do
          within all('table tr.tasks')[0] do
            expect(find('th.dead_line_on')).to have_content "2020-08-09"
          end
          within all('table tr.tasks')[1] do
            expect(find('th.dead_line_on')).to have_content "2020-07-24"
          end
        end
      end

      context "優先度が高い順" do
        before do
          click_button '優先順位順'
        end
        it "優先度が高い順に並び替える" do
          within all('table tr.tasks')[0] do
            expect(find('th.importance')).to have_content "高"
          end
          within all('table tr.tasks')[1] do
            expect(find('th.importance')).to have_content  "中"
          end
        end
      end

      context "優先度が低い順" do
        before do
          click_button '優先順位順'
          click_button '優先順位順'
        end
        it "優先度が低い順に並び替える" do
          within all('table tr.tasks')[0] do
            expect(find('th.importance')).to have_content "中"
          end
          within all('table tr.tasks')[1] do
            expect(find('th.importance')).to have_content  "高"
          end
        end
      end
    end

    describe "タスクの絞り込み検索", js: true do
      before do
        click_button '検索条件をリセット'
      end
      it "フォーム検索" do
        fill_in 'search_form', with: '2番'
        click_button "検索"
        expect(page).to have_selector('tr.tasks', count: 1)
        within all('table tr.tasks')[0] do
          expect(find('th.title')).to have_content "2番目"
        end
      end
      it "ステータス検索" do
        select '着手', from: 'search_status'
        click_button "検索"
        expect(page).to have_selector('tr.tasks', count: 1)
        within all('table tr.tasks')[0] do
          expect(find('th.status')).to have_content "着手"
        end
      end
      it "フォームとステータスで検索" do
        fill_in 'search_form', with: '1番目'
        select '着手', from: 'search_status'
        click_button "検索"
        expect(page).to have_selector('tr.tasks', count: 1)
        within all('table tr.tasks')[0] do
          expect(find('th.title')).to have_content "1番目"
          expect(find('th.status')).to have_content "着手"
        end
      end
    end

    describe "タスクの投稿" do
      context "必要な値を入力している場合" do
        before do
          click_link "タスクの投稿"
          fill_in 'task_title', with: 'feature_test'
          select '高', from: 'task_importance'
          select '2020', from: 'task_dead_line_on_1i'
          select '7', from: 'task_dead_line_on_2i'
          select '24', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: '東京オリンピック開会日'
          click_button '新しいタスクを追加'
        end
        it "タスクの作成に成功する" do
          expect(page).to have_content "新しいタスクが作成されました"
        end
      end
      context "task_titleが空の場合" do
        before do
          click_link "タスクの投稿"
          fill_in 'task_title', with: nil
          select '高', from: 'task_importance'
          select '2020', from: 'task_dead_line_on_1i'
          select '7', from: 'task_dead_line_on_2i'
          select '24', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: '東京オリンピック開会日'
          click_button '新しいタスクを追加'
        end
        it "タスクの投稿に失敗する" do
          expect(page).to have_content "タイトルを入力してください"
        end
      end
      context "task_titleが30文字以上の場合" do
        before do
          click_link "タスクの投稿"
          fill_in 'task_title', with: "12345678910/12345678910/12345678910"
          select '高', from: 'task_importance'
          select '2020', from: 'task_dead_line_on_1i'
          select '7', from: 'task_dead_line_on_2i'
          select '24', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: '東京オリンピック開会日'
          click_button '新しいタスクを追加'
        end
        it "タスクの投稿に失敗する" do
          expect(page).to have_content "タイトルは30文字以内で入力してください"
        end
      end
      context "dead_line_onの日付が過去の日付の場合" do
        before do
          click_link "タスクの投稿"
          fill_in 'task_title', with: 'feature_test'
          select '高', from: 'task_importance'
          select '2016', from: 'task_dead_line_on_1i'
          select '8', from: 'task_dead_line_on_2i'
          select '5', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: 'リオデジャネイロオリンピック開会日'
          click_button '新しいタスクを追加'
        end
        it "タスクの投稿に失敗する" do
          expect(page).to have_content "期限に過去の日付は使用できません"
        end
      end
    end
  end

  describe "個別のタスクに対して行う操作" do
    before do
      visit tasks_path
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