# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  user_id      :bigint
#  title        :string(255)      not null
#  importance   :integer          default("low")
#  dead_line_on :date
#  status       :integer          default("not_started")
#  detail       :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Taskのバリデーション' do
    let(:task) { build(:task, title: title, importance: importance, status: status, dead_line_on: dead_line_on) }
    let(:title) { 'test' }
    let(:importance) { 'low' }
    let(:status) { 'not_started' }
    let(:dead_line_on) { nil }
    subject { task.valid? }
    context 'titleが30文字以内で入力されている場合' do
      it { is_expected.to eq true }
    end
    context 'titleの値がnilの場合' do
      let(:title) { nil }
      it { is_expected.to eq false }
    end
    context 'titleが30文字以上の場合' do
      let(:title) { '12345678910/12345678910/12345678910' }
      it { is_expected.to eq false }
    end
    context '期限が過去の日付の場合' do
      let(:dead_line_on) { '2008-09-25' }
      it { is_expected.to eq false }
    end
  end
  describe 'Taskのenum' do
    describe '正しい値が入っている場合' do
      subject { build(:task, title: 'test', importance: importance, status: status) }
      context '両方に正しい文字列が入っている場合' do
        let(:importance) { 'low' }
        let(:status) { 'completed' }
        it { is_expected.to be_valid }
      end
      context '両方に正しい数字が入っている場合' do
        let(:importance) { 2 }
        let(:status) { 0 }
        it { is_expected.to be_valid }
      end
    end
    describe '正しくない値が入っている場合' do
      subject { build(:task, title: 'test', importance: importance, status: status) }
      context 'importanceの値が異常な場合' do
        let(:status) { 'not_started' }
        context 'importanceに異常な文字が入っている場合' do
          let(:importance) { 'hoge' }
          it { is_expected_block.to raise_error(ArgumentError) }
        end
        context 'importanceに異常な数字が入っている場合' do
          let(:importance) { 3 }
          it { is_expected_block.to raise_error(ArgumentError) }
        end
      end
      context 'statusの値が異常な場合' do
        let(:importance) { 'low' }
        context 'statusに異常な文字が入っている場合' do
          let(:status) { 'hoge' }
          it { is_expected_block.to raise_error(ArgumentError) }
        end
        context 'statusに異常な文字が入っている場合' do
          let(:status) { 3 }
          it { is_expected_block.to raise_error(ArgumentError) }
        end
      end
    end
  end
  describe 'Taskのscope' do
    let!(:task1) { create(:task, title: 'matched_task', status: 'working') }
    let!(:task2) { create(:task, title: 'matching', status: 'working') }
    let!(:task3) { create(:task, title: 'hoge_fuga', status: 'completed') }
    let(:search_query) { '' }
    let(:selected_status) { '' }
    describe 'by_title' do
      subject { Task.by_title(search_query).map(&:id) }
      context '検索クエリが入力されていない場合' do
        it { is_expected.to contain_exactly(task1.id, task2.id, task3.id) }
      end
      context '検索クエリが入力されている場合' do
        context 'クエリとタイトルが完全に一致する場合' do
          let(:search_query) { 'matched_task' }
          it { is_expected.to contain_exactly(task1.id) }
        end
        context 'クエリとタイトルが部分一致する場合' do
          let(:search_query) { 'match' }
          it { is_expected.to contain_exactly(task1.id, task2.id) }
        end
        context 'クエリとタイトルが部分的にも一致しない場合' do
          let(:search_query) { 'faild' }
          it { is_expected.to be_empty }
        end
      end
    end
    describe 'by_status' do
      subject { Task.by_status(selected_status).map(&:id) }
      context 'ステータスで絞り込まない場合' do
        it { is_expected.to contain_exactly(task1.id, task2.id, task3.id) }
      end
      context 'ステータスで絞り込む場合' do
        context '選択したステータスと同じステータスのタスクがある場合' do
          let(:selected_status) { 'working' }
          it { is_expected.to contain_exactly(task1.id, task2.id) }
        end
        context '選択したステータスと同じステータスのタスクがない場合' do
          let(:selected_status) { 'not_started' }
          it { is_expected.to be_empty }
        end
      end
    end
    describe 'search' do
      subject { Task.search(search_query, selected_status).map(&:id) }
      context 'クエリとステータスの両方で絞り込む場合' do
        context 'クエリとタイトルが一致し、ステータスが同じする場合' do
          let(:search_query) { 'match' }
          let(:selected_status) { 'working' }
          it { is_expected.to contain_exactly(task1.id, task2.id) }
        end
        context 'クエリとタイトルは一致するが、ステータスが異なる場合' do
          let(:search_query) { 'match' }
          let(:selected_status) { 'completed' }
          it { is_expected.to be_empty }
        end
      end
      context 'どちらか片方で絞り込む場合' do
        context 'クエリのみで絞り込む場合' do
          let(:search_query) { 'match' }
          it { is_expected.to contain_exactly(task1.id, task2.id) }
        end
        context 'ステータスのみで絞り込む場合' do
          let(:selected_status) { 'completed' }
          it { is_expected.to contain_exactly(task3.id) }
        end
      end
    end
  end
end
