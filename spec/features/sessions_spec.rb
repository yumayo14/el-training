# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sessions', type: :feature, js: true do
  describe 'ログイン' do
    let(:accountid) { 'Iamtest' }
    let(:password) { 'testPassword' }
    let!(:user) { create(:user, accountid: accountid, password: password) }
    before do
      visit new_session_path
    end
    context '登録されているユーザーと同じアカウントIDとパスワードが入力されている場合' do
      before do
        fill_in 'accountid', with: accountid
        fill_in 'password', with: password
        click_button 'ログイン'
      end
      it 'タスク一覧画面に遷移する' do
        expect(page).to have_content 'タスク一覧'
      end
    end
    context '登録されているユーザーとアカウントIDとパスワードが異なる場合' do
      before do
        fill_in 'accountid', with: 'hogehoge'
        fill_in 'password', with: 'testtest'
        click_button 'ログイン'
      end
      it '画面は変わらない' do
        expect(current_path).to eq new_session_path
      end
      context '入力を間違えた後、登録されているユーザーのアカウントIDとパスワードを入力した場合' do
        before do
          sleep 2
          fill_in 'accountid', with: accountid
          fill_in 'password', with: password
          click_button 'ログイン'
        end
        it 'タスク一覧画面に遷移する' do
          expect(page).to have_content 'タスク一覧'
        end
      end
    end
  end
end
