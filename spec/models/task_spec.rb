# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Taskのバリデーション' do
    context 'titleが30文字以内で入力されている場合' do
      it '保存できる' do
        task = FactoryBot.build(:task)
        expect(task.valid?).to eq true
      end
    end
    context 'titleの値がnilの場合' do
      it '保存できない' do
        task = FactoryBot.build(:task, title: nil)
        expect(task.valid?).to eq false
      end
    end
    context 'titleが30文字以上の場合' do
      it '保存できない' do
        task = FactoryBot.build(:task, title: '12345678910/12345678910/12345678910')
        expect(task.valid?).to eq false
      end
    end
    context 'importanceが(低, 中, 高)以外の場合' do
      it '作成できない' do
        expect { FactoryBot.build(:task, importance: 'sasa') }.to raise_error(ArgumentError)
        expect { FactoryBot.build(:task, importance: 99) }.to raise_error(ArgumentError)
      end
    end
    context 'statusが(未着手, 着手, 完了)以外の場合' do
      it '作成できない' do
        expect { FactoryBot.build(:task, status: 'sasa') }.to raise_error(ArgumentError)
        expect { FactoryBot.build(:task, status: 99) }.to raise_error(ArgumentError)
      end
    end
    context '期限が過去の日付の場合' do
      it '作成できない' do
        task = FactoryBot.build(:task, dead_line_on: '2008-09-25')
        expect(task.valid?).to eq false
      end
    end
  end
  describe 'Taskのscope' do
    let!(:task1) { create(:task, title: 'matched_task', status: '着手') }
    let!(:task2) { create(:task, title: 'matching', status: '着手') }
    let!(:task3) { create(:task, title: 'hoge_fuga', status: '完了') }
    let(:search_query) { '' }
    let(:selected_status) { '未着手' }
    describe 'search_by_title' do
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
    describe 'search_by_status' do
      subject { Task.by_status(selected_status).map(&:id) }
      context 'ステータスで絞り込まない場合' do
        it '全てのタスクが返ってくる'
      end
      context 'ステータスで絞り込む場合' do
        context '選択したステータスと同じステータスのタスクがある場合' do
          let(:selected_status) { '着手' }
          it { is_expected.to contain_exactly(task1.id, task2.id) }
        end
        context '選択したステータスと同じステータスのタスクがない場合' do
          let(:selected_status) { '未着手' }
          it { is_expected.to be_empty }
        end
      end
    end
    describe 'search' do
      subject { Task.search(search_query, selected_status).map(&:id) }
      context 'クエリとステータスの両方で絞り込む場合' do
        context 'クエリとタイトルが一致し、ステータスが同じする場合' do
          let(:search_query) { 'match' }
          let(:selected_status) { '着手' }
          it { is_expected.to contain_exactly(task1.id, task2.id) }
        end
        context 'クエリとタイトルは一致するが、ステータスが異なる場合' do
          let(:search_query) { 'match' }
          let(:selected_status) { '完了' }
          it { is_expected.to be_empty }
        end
      end
      context 'どちらか片方で絞り込む場合' do
        context 'クエリのみで絞り込む場合' do
          it 'クエリとタイトルが一致するタスクの一覧が返ってくる'
        end
        context 'ステータスのみで絞り込む場合' do
          let(:selected_status) { '完了' }
          it { is_expected.to contain_exactly(task3.id) }
        end
      end
    end
  end
end
