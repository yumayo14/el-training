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
          let(:searched_tasks) { JSON.parse(response.body)['nested']['data']  }
          it '検索文言とタイトル名が部分一致するタスクのみ表示される' do
            expect(searched_tasks.length).to eq 2
            expect(searched_tasks[0]['title']).to include title
            expect(searched_tasks[1]['title']).to include title
          end
        end
        context 'ステータスのみで検索する場合' do
          let(:status) { 'working' }
          before { search_request }
          let(:searched_tasks) { JSON.parse(response.body)['nested']['data']  }
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
          let(:searched_tasks) { JSON.parse(response.body)['nested']['data']  }
          it '検索文言とタイトル名が部分一致した上でステータスが同じタスクのみ表示される' do
            expect(searched_tasks.length).to eq 1
            expect(searched_tasks[0]['title']).to include title
            expect(searched_tasks[0]['status']['text']).to eq '着手'
          end
        end
      end
    end
  end
end
