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
  describe 'バリデーション' do
    let(:user) { build(:user, name: name, accountid: accountid, password: password) }
    let(:name) { '田中 太郎' }
    let(:accountid) { 'tanatarou' }
    let(:password) { 'morethan8' }
    subject { user.valid?(:password_change) }
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
  describe 'パスワードの暗号化' do
    let!(:user) { create(:user, password: password) }
    let(:password) { 'morethan8' }
    describe '平文を含まない様に暗号化している' do
      subject { user.hashed_password }
      it { is_expected.not_to include password }
    end
    context 'ユーザー情報が更新された場合' do
      let!(:previous_hashed_password) { user.hashed_password }
      context 'パスワードが更新された場合' do
        before { user.password = new_password }
        context '新しいパスワードが8文字より多い場合' do
          let(:new_password) { 'newpassword' }
          subject { user.save(context: :password_change) }
          it { is_expected.to eq true }
        end
        context '新しいパスワードが8文字より少ない場合' do
          let(:new_password) { 'new' }
          subject { user.save(context: :password_change) }
          it { is_expected.to eq false }
        end
      end
      context 'パスワード以外の情報が更新された場合' do
        let(:new_name) { 'newname' }
        before { user.update(name: new_name) }
        describe 'パスワード情報は更新されない' do
          subject { user.hashed_password }
          it { is_expected.to eq previous_hashed_password }
        end
      end
    end
  end
  describe 'メソッド' do
    let!(:user) { create(:user, password: password) }
    let(:password) { 'morethan8' }
    describe '#authenticated?' do
      let(:login_password) { '' }
      subject { user.authenticated?(login_password) }
      context '入力されたパスワードが登録時と同じ場合' do
        let(:login_password) { 'morethan8' }
        it { is_expected.to eq true }
      end
      context '入力されたパスワードが登録時と異なる場合' do
        let(:login_password) { 'differentpassword' }
        it { is_expected.to eq false }
      end
    end
    describe '#make_cookie_token!' do
      before { user.make_cookie_token! }
      it 'cookie_tokenがユーザーに紐づけられる' do
        expect(user.cookie_token).to be_present
        expect(user.cookie_token.length).to eq 22
      end
      describe 'ハッシュ化されたcookie_tokenがデータベースに保存される' do
        subject { user.hashed_cookie_token }
        it { is_expected.to be_present }
        it { is_expected.not_to include user.cookie_token }
      end
    end
    describe '#delete_cookie_token!' do
      before do
        user.make_cookie_token!
        user.delete_cookie_token!
      end
      it '紐づけられていたcookie_tokenがなくなる' do
        expect(user.cookie_token).to eq nil
      end
      it 'データベースに保村されていたcookie_tokenがなくなる' do
        expect(user.hashed_cookie_token).to eq nil
      end
    end
  end
end
