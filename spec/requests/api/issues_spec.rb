# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Issues', type: :request do
  describe '#index' do
    let!(:issue) { create(:issue, title: 'test_issue') }
    before { get api_issues_path }
    it '投稿されたタスクの一覧が配列で返る' do
      expect(JSON.parse(response.body)[0]['title']).to eq 'test_issue'
    end
    it 'ステータス200を返す' do
      expect(response.status).to eq 200
    end
  end
end
