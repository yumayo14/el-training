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
    let!(:login_users_task) { create(:task, title: 'login_users_task', user: user) }
    let!(:other_users_task) { create(:task) }
    context 'ログインを行なっている場合' do
      context '絞り込み検索を行わない場合' do
        before do
          2.times { create(:task, title: 'login_userd_task', user: user) }
          3.times { create(:task) }
          get api_tasks_path
        end
        let(:login_user_tasks) { JSON.parse(response.body)['nested']['data'] }
        it '自分が投稿したタスクのみが表示される' do
          expect(login_user_tasks.length).to eq 2
          expect(login_user_tasks[0]['title']).to eq 'login_userd_task'
          expect(login_user_tasks[1]['title']).to eq 'login_userd_task'
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
    context '必要な値が、全て送られてきている場合' do
      it '投稿に成功する' do
        task_create_request
        created_task = JSON.parse(response.body)['task']
        expect(created_task['title']).to eq 'test_task'
        expect(response.status).to eq 200
      end
    end
    context 'titleが空の場合' do
      let(:title) { '' }
      it '投稿に失敗する' do
        task_create_request
        error_messages = JSON.parse(response.body)
        expect(error_messages).to include 'タイトルを入力してください'
        expect(response.status).to eq 400
      end
    end
    context 'titleが30文字以上の場合' do
      let(:title) { '12345678910/12345678910/12345678910/' }
      it '投稿に失敗する' do
        task_create_request
        error_messages = JSON.parse(response.body)
        expect(error_messages).to include 'タイトルは30文字以内で入力してください'
        expect(response.status).to eq 400
      end
    end
    context 'dead_line_onが過去の日付の場合' do
      let(:dead_line_on) { '2019-04-01' }
      it '投稿に失敗する' do
        task_create_request
        error_messages = JSON.parse(response.body)
        expect(error_messages).to include '期限に過去の日付は使用できません'
        expect(response.status).to eq 400
      end
    end
  end
end
