# frozen_string_literal: true

# == Schema Information
#
# Table name: issues
#
#  id           :bigint           not null, primary key
#  dead_line_on :date             not null
#  status       :integer          default("未着手")
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_issues_on_status   (status)
#  index_issues_on_title    (title)
#  index_issues_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_f8f1052133  (user_id => users.id) ON DELETE => cascade
#

require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'Issueのバリデーション' do
    let(:issue) { build(:issue, title: title, status: status, dead_line_on: dead_line_on) }
    subject { issue.valid? }
    describe ' Issueのtitle' do
      let(:status) { '未着手' }
      let(:dead_line_on) { Time.zone.tomorrow }
      context 'titleが入力されていない場合' do
        let(:title) { '' }
        it { is_expected.to eq false }
      end
    end
    describe 'Issueのstatus' do
      let(:title) { 'test' }
      let(:dead_line_on) { Time.zone.tomorrow }
      context 'statusが入力されていない場合' do
        let(:status) { '' }
        it { is_expected.to eq false }
      end
      context 'statusが「未着手」、「着手」、「完了」以外の文字列の場合' do
        let(:title) { 'test' }
        let(:status) { '終了' }
        let(:dead_line_on) { Time.zone.tomorrow }
        it { is_expected_block.to raise_error(ArgumentError) }
      end
    end
    describe 'Issueのdead_line_on' do
      let(:title) { 'test' }
      let(:status) { '未着手' }
      context 'dead_line_onが過去の日付の場合' do
        let(:dead_line_on) { Time.zone.yesterday }
        it { is_expected.to eq false }
      end
      context 'dead_line_onが今日の日付の場合' do
        let(:dead_line_on) { Time.zone.today }
        it { is_expected.to eq true }
      end
      context 'dead_line_onが3年後の日付の場合' do
        let(:dead_line_on) { Time.zone.today.since(3.years) }
        it { is_expected.to eq true }
      end
    end
  end
  describe 'Issueのコールバック' do
    describe '#create_associated_three_steps' do
      let(:issue) { create(:issue) }
      it '投稿したIssueに紐づくステップが3つ作成される' do
        expect(issue.steps.count).to eq 3
      end
    end
  end
end
