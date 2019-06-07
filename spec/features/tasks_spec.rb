# frozen_string_literal: true

require 'rails_helper'

RSpec.feature'Tasks', type: :feature, js: true do
  let!(:user) { create(:user, accountid: 'IamTest', password: 'testPassword') }
  context 'ログインしている場合' do
    before do
      visit login_path
      fill_in 'accountid', with: 'IamTest'
      fill_in 'password', with: 'testPassword'
      click_button 'ログイン'
      sleep 1
    end
    describe 'タスクの一覧表示' do
      let!(:tasks_for_listing_test) do
        create(:task, title: 'Test2', user: user, importance: 2, status: 0, dead_line_on: '2020-07-24', created_at: '2020/07/24 16:00::55')
        create(:task, title: 'Test1', user: user, importance: 1, status: 1, dead_line_on: '2020-08-09', created_at: '2020/08/09 09:00:00')
      end
      before { visit tasks_path }
      describe '最初の並び順' do
        it 'indexページに投稿されたタスクの一覧が表示される' do
          within all('tr.tasks')[0] do
            expect(find('th.title')).to have_content 'Test1'
            expect(find('th.importance')).to have_content '中'
            expect(find('th.status')).to have_content '着手'
            expect(find('th.dead_line_on')).to have_content '2020-08-09'
            expect(find('th.created_day')).to have_content '2020/08/09'
          end
          within all('tr.tasks')[1] do
            expect(find('th.title')).to have_content 'Test2'
            expect(find('th.importance')).to have_content '高'
            expect(find('th.status')).to have_content '未着手'
            expect(find('th.dead_line_on')).to have_content '2020-07-24'
            expect(find('th.created_day')).to have_content '2020/07/24'
          end
        end
        it 'ページ遷移後、投稿日が新しい順に並んでいる' do
          within all('tr.tasks')[0] do
            expect(find('th.created_day')).to have_content '2020/08/09'
          end
          within all('tr.tasks')[1] do
            expect(find('th.created_day')).to have_content '2020/07/24'
          end
        end
      end

      describe '並び替え' do
        context '投稿日が新しい順' do
          before { click_button '投稿日順' }
          it '投稿日が新しい順に並び替える' do
            within all('tr.tasks')[0] do
              expect(find('th.created_day')).to have_content '2020/08/09'
            end
            within all('tr.tasks')[1] do
              expect(find('th.created_day')).to have_content '2020/07/24'
            end
          end
        end

        context '投稿日が古い順' do
          before do
            click_button '投稿日順'
            click_button '投稿日順'
          end
          it '投稿日が古い順に並び替える' do
            within all('tr.tasks')[0] do
              expect(find('th.created_day')).to have_content '2020/07/24'
            end
            within all('tr.tasks')[1] do
              expect(find('th.created_day')).to have_content  '2020/08/09'
            end
          end
        end

        context '期限日が近い順' do
          before { click_button '期限日順' }
          it '期限が近い順に並び替える' do
            within all('tr.tasks')[0] do
              expect(find('th.dead_line_on')).to have_content '2020-07-24'
            end
            within all('tr.tasks')[1] do
              expect(find('th.dead_line_on')).to have_content '2020-08-09'
            end
          end
        end
        context '期限日が遠いの順' do
          before do
            click_button '期限日順'
            click_button '期限日順'
          end
          it '期限が遠い順に並び替える' do
            within all('tr.tasks')[0] do
              expect(find('th.dead_line_on')).to have_content '2020-08-09'
            end
            within all('tr.tasks')[1] do
              expect(find('th.dead_line_on')).to have_content '2020-07-24'
            end
          end
        end

        context '優先度が高い順' do
          before { click_button '優先順位順' }
          it '優先度が高い順に並び替える' do
            within all('tr.tasks')[0] do
              expect(find('th.importance')).to have_content '高'
            end
            within all('tr.tasks')[1] do
              expect(find('th.importance')).to have_content '中'
            end
          end
        end

        context '優先度が低い順' do
          before do
            click_button '優先順位順'
            click_button '優先順位順'
          end
          it '優先度が低い順に並び替える' do
            within all('tr.tasks')[0] do
              expect(find('th.importance')).to have_content '中'
            end
            within all('tr.tasks')[1] do
              expect(find('th.importance')).to have_content '高'
            end
          end
        end
      end

      describe '絞り込み検索' do
        before { click_button '検索条件をリセット' }
        context 'タイトル名でのみ検索する場合' do
          before do
            fill_in 'query', with: 'Test2'
            click_button '検索'
          end
          it '検索文言とタイトル名が部分一致するタスクのみ表示される' do
            expect(page).to have_selector 'tr.tasks', count: 1
            within all('tr.tasks')[0] do
              expect(find('th.title')).to have_content 'Test2'
            end
          end
        end
        context 'ステータスのみで検索する場合' do
          before do
            select '着手', from: 'status'
            click_button '検索'
          end
          it '同じステータスのタスクのみが表示される' do
            expect(page).to have_selector 'tr.tasks', count: 1
            within all('tr.tasks')[0] do
              expect(find('th.status')).to have_content '着手'
            end
          end
        end
        context 'タイトル名とステータスで検索する場合' do
          before do
            fill_in 'query', with: 'Test1'
            select '着手', from: 'status'
            click_button '検索'
          end
          it '検索文言とタイトル名が部分一致した上でステータスが同じタスクのみが表示される' do
            expect(page).to have_selector 'tr.tasks', count: 1
            within all('tr.tasks')[0] do
              expect(find('th.title')).to have_content 'Test1'
              expect(find('th.status')).to have_content '着手'
            end
          end
        end
      end
    end

    describe 'タスクの投稿' do
      context '必要な値を入力している場合' do
        before do
          click_link 'タスクの投稿'
          fill_in 'task_title', with: 'feature_test'
          select '高', from: 'task_importance'
          select '2020', from: 'task_dead_line_on_1i'
          select '7', from: 'task_dead_line_on_2i'
          select '24', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: '東京オリンピック開会日'
          click_button '登録する'
        end
        it '投稿に成功する' do
          expect(page).to have_content '新しいタスクが作成されました'
        end
      end
      context 'task_titleが空の場合' do
        before do
          click_link 'タスクの投稿'
          fill_in 'task_title', with: nil
          select '高', from: 'task_importance'
          select '2020', from: 'task_dead_line_on_1i'
          select '7', from: 'task_dead_line_on_2i'
          select '24', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: '東京オリンピック開会日'
          click_button '登録する'
        end
        it '投稿に失敗する' do
          expect(page).to have_content 'タスクの作成に失敗しました'
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
      context 'task_titleが30文字以上の場合' do
        before do
          click_link 'タスクの投稿'
          fill_in 'task_title', with: '12345678910/12345678910/12345678910'
          select '高', from: 'task_importance'
          select '2020', from: 'task_dead_line_on_1i'
          select '7', from: 'task_dead_line_on_2i'
          select '24', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: '東京オリンピック開会日'
          click_button '登録する'
        end
        it '投稿に失敗する' do
          expect(page).to have_content 'タスクの作成に失敗しました'
          expect(page).to have_content 'タイトルは30文字以内で入力してください'
        end
      end
      context 'dead_line_onの日付が過去の日付の場合' do
        before do
          click_link 'タスクの投稿'
          fill_in 'task_title', with: 'feature_test'
          select '高', from: 'task_importance'
          select '2016', from: 'task_dead_line_on_1i'
          select '8', from: 'task_dead_line_on_2i'
          select '5', from: 'task_dead_line_on_3i'
          select '着手', from: 'task_status'
          fill_in 'task_detail', with: 'リオデジャネイロオリンピック開会日'
          click_button '登録する'
        end
        it '投稿に失敗する' do
          expect(page).to have_content 'タスクの作成に失敗しました'
          expect(page).to have_content '期限に過去の日付は使用できません'
        end
      end
    end

    describe 'タスクを表示しているページの切り替え' do
      context '10個以下の場合' do
        let!(:tasks_for_pagination_test) { 10.times { create(:task, user: user) } }
        before do
          visit tasks_path
        end
        it '10個まで表示される' do
          expect(all('tr.tasks').size).to eq 10
        end
        it 'ページネーションできない' do
          expect(page).to have_button 'Go Next', disabled: true
          expect(page).to have_button 'Go Back', disabled: true
        end
      end
      context 'タスクが11個以上から20個の場合' do
        let!(:tasks_for_pagination_test) { 20.times { create(:task, user: user) } }
        before do
          visit tasks_path
          click_button 'Go Next'
        end
        it '2ページ目に11個目から20個目までが表示される' do
          expect(all('tr.tasks').size).to eq 10
        end
      end
    end

    describe 'タスクの編集、更新、削除' do
      let(:task) { create(:task, user: user) }
      before do
        visit tasks_path
        visit task_path(task.id)
      end

      describe '編集と更新' do
        context '必要な値を入力している場合' do
          before do
            click_link '編集'
            fill_in 'task_title', with: 'タスクの更新'
            click_button '更新する'
          end
          it '作成したタスクの更新する' do
            expect(page).to have_content 'タスクの内容が更新されました'
          end
        end
      end

      describe '削除' do
        before { click_link '削除' }
        context '確認時、Yesを選んだ場合' do
          before { page.driver.browser.switch_to.alert.accept }
          it '削除される' do
            expect(page).to have_content 'タスクを削除しました'
          end
        end
        context '確認時、Noを選んだ場合' do
          before { page.driver.browser.switch_to.alert.dismiss }
          it '削除されない' do
            expect(page).to have_content 'タスクの詳細'
          end
        end
      end
    end
  end
  context 'ログインしていない場合' do
    context 'ログインせず、別の画面に遷移しようとした場合' do
      before { visit tasks_path }
      it 'ログイン画面に遷移する' do
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインを行なってください'
      end
    end
    context 'ログイン画面から別の画面に遷移しようとした場合' do
      before { visit login_path }
      context 'タスク一覧画面に遷移しようとした場合' do
        before { click_link 'タスク一覧' }
        it 'ログイン画面に遷移する' do
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインを行なってください'
        end
      end
      context 'タスク投稿画面に遷移しようとした場合' do
        before { click_link 'タスクの投稿' }
        it 'タスク投稿画面に遷移しようとしても、ログイン画面に遷移する' do
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインを行なってください'
        end
      end
    end
  end
end
