# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Taskのバリデーション" do
    context "titleが30文字以内で入力されている場合" do
      it "保存できる" do
        task = FactoryBot.build(:task)
        expect(task.valid?).to eq true
      end
    end
    context "titleの値がnilの場合" do
      it "保存できない" do
        task = FactoryBot.build(:task, title: nil)
        expect(task.valid?).to eq false
      end
    end
    context "titleが30文字以上の場合" do
      it "保存できない" do
        task = FactoryBot.build(:task, title: "12345678910/12345678910/12345678910")
        expect(task.valid?).to eq false
      end
    end
    context "importanceが(低, 中, 高)以外の場合" do
      it "作成できない" do
        expect{FactoryBot.build(:task, importance: "sasa")}.to raise_error(ArgumentError)
        expect{ FactoryBot.build(:task, importance: 99)}.to raise_error(ArgumentError)
      end
    end
    context "statusが(未着手, 着手, 完了)以外の場合" do
      it "作成できない" do
        expect{FactoryBot.build(:task, status: "sasa")}.to raise_error(ArgumentError)
        expect{FactoryBot.build(:task, status: 99)}.to raise_error(ArgumentError)
      end
    end
    context "期限が過去の日付の場合" do
      it "作成できない" do
        task = FactoryBot.build(:task, dead_line_on: "2008-09-25")
        expect(task.valid?).to eq false
      end
    end
  end
end
