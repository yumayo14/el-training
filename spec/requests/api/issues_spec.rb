# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Issues', type: :request do
  let!(:user) { create(:user, accountid: 'tester', password: 'IamTestMan') }
  before do
    post login_path, params: {
      accountid: 'tester',
      password: 'IamTestMan'
    }
  end
  describe '#index' do
    let!(:login_users_issue) { create(:issue, title: 'login_users_issue', user: user) }
    let!(:other_users_issue) { create(:issue, title: 'other_users_issue') }
    before { get api_issues_path }
    it '自分が投稿した問題の一覧が返る' do
      expect(JSON.parse(response.body).length).to eq 1
      expect(JSON.parse(response.body)[0]['title']).to eq 'login_users_issue'
    end
    it 'ステータス200を返す' do
      expect(response.status).to eq 200
    end
  end
  describe '#create' do
    let(:title) { 'test_title' }
    let(:status) { '未着手' }
    let(:dead_line_on) { '2019-09-21' }
    let(:created_task) { JSON.parse(response.body) }
    before do
      post api_issues_path, params: {
        title: title,
        status: status,
        dead_line_on: dead_line_on
      }
    end
    it '投稿に成功する' do
      expect(created_task['title']).to eq 'test_title'
      expect(response.status).to eq 200
    end
  end
end
