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
    before do
      post api_issues_path, params: {
        title: title,
        status: status,
        dead_line_on: dead_line_on
      }
    end
    context '全ての値が正常な場合' do
      let(:created_task) { JSON.parse(response.body) }
      let(:title) { 'test_title' }
      let(:status) { '未着手' }
      let(:dead_line_on) { Time.zone.tomorrow }
      it '投稿に成功する' do
        expect(created_task['title']).to eq 'test_title'
      end
      it '200のステータスを返す' do
        expect(response.status).to eq 200
      end
    end
    context '不正な値がある場合' do
      let(:error_messages) { JSON.parse(response.body) }
      let(:title) { '' }
      let(:status) { '未着手' }
      let(:dead_line_on) { Time.zone.yesterday }
      it '該当するエラーメッセージを返す' do
        expect(error_messages).to include 'タイトルを入力してください'
        expect(error_messages).to include '期限は今日以降の日付を入力してください'
      end
      it '400のステータスを返す' do
        expect(response.status).to eq 400
      end
    end
  end
end
