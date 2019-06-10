# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  let!(:user) { create(:user, accountid: 'tester', password: 'IamTestMan') }
  before do
    post login_path, params: {
      accountid: 'tester',
      password: 'IamTestMan'
    }
    2.times { create(:task, title: 'login_userd_task', user: user) }
    3.times { create(:task) }
  end
  describe 'GET#index' do
    context 'ログインを行なっている場合' do
      it '自分が投稿したタスクのみが表示される' do
        get api_tasks_path
        login_user_tasks = JSON.parse(response.body)['nested']['data']
        expect(login_user_tasks.length).to eq 2
        expect(login_user_tasks[0]['title']).to eq 'login_userd_task'
        expect(login_user_tasks[1]['title']).to eq 'login_userd_task'
      end
    end
  end
end
