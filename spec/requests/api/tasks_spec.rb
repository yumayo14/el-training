# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  let!(:user) { create(:user, accountid: 'tester', password: 'IamTestMan') }
  before do
    post login_path, params: {
      accountid: 'tester',
      password: 'IamTestMan'
    }
  end
  describe 'GET#index' do
    context 'ログインを行なっている場合' do
      context '絞り込み検索を行わない場合' do
        let!(:login_users_task) { create(:task, title: 'login_users_task', user: user) }
        let!(:other_users_task) { create(:task) }
        before { get api_tasks_path }
        let(:responded_task) { JSON.parse(response.body)['nested']['data'] }
        it '自分が投稿したタスクのみが表示される' do
          expect(responded_task.length).to eq 1
          expect(responded_task[0]['title']).to eq 'login_users_task'
        end
      end
      context '絞り込み検索を行う場合' do
        let!(:task_for_title_search) { create(:task, title: 'search_test', status: 'completed', user: user) }
        let!(:task_for_status_search) { create(:task, title: 'not_matching', status: 'working', user: user) }
        let!(:same_title_status_task) { create(:task, title: 'search', status: 'working', user: user) }
        let(:title) { '' }
        let(:status) { '' }
        let(:search_request) do
          get api_tasks_path, params: {
            title: title,
            status: status
          }
        end
        context 'タスク名でのみ検索する場合' do
          let(:title) { 'search' }
          before { search_request }
          let(:searched_tasks) { JSON.parse(response.body)['nested']['data'] }
          it '検索文言とタイトル名が部分一致するタスクのみ表示される' do
            expect(searched_tasks.length).to eq 2
            expect(searched_tasks[0]['title']).to include title
            expect(searched_tasks[1]['title']).to include title
          end
        end
        context 'ステータスのみで検索する場合' do
          let(:status) { 'working' }
          before { search_request }
          let(:searched_tasks) { JSON.parse(response.body)['nested']['data'] }
          it '同じステータスのタスクのみが表示される' do
            expect(searched_tasks.length).to eq 2
            expect(searched_tasks[0]['status']['text']).to eq '着手'
            expect(searched_tasks[1]['status']['text']).to eq '着手'
          end
        end
        context 'タスク名とステータスで検索する場合' do
          let(:title) { 'search' }
          let(:status) { 'working' }
          before { search_request }
          let(:searched_tasks) { JSON.parse(response.body)['nested']['data'] }
          it '検索文言とタイトル名が部分一致した上でステータスが同じタスクのみ表示される' do
            expect(searched_tasks.length).to eq 1
            expect(searched_tasks[0]['title']).to include title
            expect(searched_tasks[0]['status']['text']).to eq '着手'
          end
        end
      end
    end
  end
  describe 'POST#create' do
    let(:title) { 'test_task' }
    let(:importance) { 'low' }
    let(:dead_line_on) { '2022-01-13' }
    let(:status) { 'working' }
    let(:detail) { 'this_is_the_doc' }
    let(:task_create_request) do
      post api_tasks_path, params: {
        title: title,
        importance: importance,
        dead_line_on: dead_line_on,
        status: status,
        detail: detail
      }
    end
    context '必要な値が全て送られてきている場合' do
      before { task_create_request }
      let(:created_task) { JSON.parse(response.body)['task'] }
      it '投稿に成功する' do
        expect(created_task['title']).to eq 'test_task'
        expect(response.status).to eq 200
      end
    end
    context '必要な値が送られて来ていない場合' do
      context 'titleが空の場合' do
        let(:title) { '' }
        before { task_create_request }
        let(:error_messages) { JSON.parse(response.body) }
        it '投稿に失敗する' do
          expect(error_messages).to include 'タイトルを入力してください'
          expect(response.status).to eq 400
        end
      end
      context 'titleが30文字以上の場合' do
        let(:title) { '12345678910/12345678910/12345678910/' }
        before { task_create_request }
        let(:error_messages) { JSON.parse(response.body) }
        it '投稿に失敗する' do
          expect(error_messages).to include 'タイトルは30文字以内で入力してください'
          expect(response.status).to eq 400
        end
      end
      context 'dead_line_onが過去の日付の場合' do
        let(:dead_line_on) { '2019-04-01' }
        before { task_create_request }
        let(:error_messages) { JSON.parse(response.body) }
        it '投稿に失敗する' do
          expect(error_messages).to include '期限に過去の日付は使用できません'
          expect(response.status).to eq 400
        end
      end
    end
  end
  describe 'DELETE#destroy' do
    context 'タスクの削除に成功した場合' do
      let!(:created_task) { create(:task, user: user) }
      before { delete api_task_path(created_task.id) }
      it '削除後、遷移先の画面のURLがレスポンスで返る' do
        expect(response.body).to eq '/tasks'
      end
      it '200のステータスが返る' do
        expect(response.status).to eq 200
      end
    end
    context 'タスクの削除に失敗した場合' do
      let!(:task_for_failed_test_case) { create(:task, user: user) }
      context '削除しようとしたタスクが見つからなかった場合' do
        before do
          task_for_failed_test_case.destroy
          delete api_task_path(task_for_failed_test_case.id)
        end
        it 'エラーメッセージを返す' do
          expect(response.body).to eq '選択したタスクが見つかりませんでした'
        end
        it '404のステータスが返る' do
          expect(response.status).to eq 404
        end
      end
    end
  end
  describe 'PATCH#update' do
    let(:created_task) { create(:task, user: user) }
    let(:title) { created_task.title }
    let(:importance) { created_task.importance }
    let(:dead_line_on) { created_task.dead_line_on }
    let(:status) { created_task.status }
    let(:detail) { created_task.detail }
    let(:task_update_request) do
      patch api_task_path(created_task.id), params: {
        title: title,
        importance: importance,
        dead_line_on: dead_line_on,
        status: status,
        detail: detail
      }
    end
    context 'タスクの更新に成功した場合' do
      let(:title) { 'update_task_title' }
      before { task_update_request }
      let(:updated_task) { JSON.parse(response.body)['task'] }
      let(:redirect_url_after_update) { JSON.parse(response.body)['redirect_url'] }
      it '更新されたタスクの情報とredirect先のurlが返る' do
        expect(updated_task['title']).to eq 'update_task_title'
        expect(redirect_url_after_update).to eq '/tasks'
      end
      it '200のステータスを返す' do
        expect(response.status).to eq 200
      end
    end
    context 'タスクの更新に失敗した場合' do
      context '更新しようとしたタスクが存在しなかった場合' do
        before do
          created_task.destroy
          task_update_request
        end
        it 'エラーメッセージを返す' do
          expect(response.body).to eq '選択したタスクが見つかりませんでした'
        end
        it '404のステータスを返す' do
          expect(response.status).to eq 404
        end
      end
      context 'タスクのタイトルを30文字以上で更新しようとした場合' do
        let(:title) { '12345678910/12345678910/12345678910/' }
        before { task_update_request }
        let(:error_messages) { JSON.parse(response.body) }
        it 'エラーメッセージを返す' do
          expect(error_messages).to include 'タイトルは30文字以内で入力してください'
        end
        it '400のステータスを返す' do
          expect(response.status).to eq 400
        end
      end
      context '期限を更新日より前にしてしまった場合' do
        let(:dead_line_on) { '2019-04-01' }
        before { task_update_request }
        let(:error_messages) { JSON.parse(response.body) }
        it 'エラーメッセージを返す' do
          expect(error_messages).to include '期限に過去の日付は使用できません'
        end
        it '400のステータスを返す' do
          expect(response.status).to eq 400
        end
      end
    end
  end
end
