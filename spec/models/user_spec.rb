# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  accountid  :string(255)      default("0"), not null
#  password   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userのバリデーション' do
    let(:user) { build(:user, name: name, accountid: accountid, password: password) }
    let(:name) { '田中 太郎' }
    let(:accountid) { 'tanatarou' }
    let(:password) { 'morethan8' }
    subject { user.valid? }
    context '名前が20文字以内の場合' do
      it { is_expected.to eq true }
    end
    context '名前が入力されていない場合' do
      let(:name) { nil }
      it { is_expected.to eq false }
    end
    context '名前が20文字より多い場合' do
      let(:name) { '私の名前は20文字より多いので名前を書くのにも一苦労です' }
      it { is_expected.to eq false }
    end
    context 'アカウントIDが15文字以内の場合' do
      it { is_expected.to eq true }
    end
    context 'アカウントIDが入力されていない場合' do
      let(:accountid) { nil }
      it { is_expected.to eq false }
    end
    context 'アカウントIDが15文字より多い場合' do
      let(:accountid) { '1a2b3c4d5e6f7g8h' }
      it { is_expected.to eq false }
    end
    context '既存のユーザーと同じアカウントIDで登録しようとした場合' do
      let!(:same_accountid_user) { create(:user, name: '田中 宏和', accountid: 'tanahiro', password: 'morethan8') }
      let(:accountid) { 'tanahiro' }
      it { is_expected.to eq false }
    end
    context 'パスワードが8文字以上の場合' do
      it { is_expected.to eq true }
    end
    context 'パスワードが入力されていない場合' do
      let(:password) { nil }
      it { is_expected.to eq false }
    end
    context 'パスワードが8文字より少ない場合' do
      let(:password) { '1a2b3c4' }
      it { is_expected.to eq false }
    end
  end
end
