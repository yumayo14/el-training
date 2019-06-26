# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sessions', type: :feature, js: true do
  describe 'ログイン' do
    let(:accountid) { 'Iamtest' }
    let(:password) { 'testPassword' }
    let!(:user) { create(:user, accountid: accountid, password: password) }
    before do
      visit login_path
    end
    context '登録されているユーザーと同じアカウントIDとパスワードが入力されている場合' do
      before do
        fill_in 'accountid', with: accountid
        fill_in 'password', with: password
        click_button 'ログイン'
        expect(page).to have_content 'タスク一覧'
      end
      it 'タスク一覧画面に遷移する'
      context 'ログインした後' do
        before { visit tasks_path }
        it 'ログインのリンクが表示されなくなり、ログアウトのリンクが表示される' do
          expect(page).not_to have_selector 'a#login_link', text: 'ログイン'
          expect(page).to have_selector 'a#logout_link', text: 'ログアウト'
        end
      end
    end
    context '登録されているユーザーとアカウントIDとパスワードが異なる場合' do
      before do
        fill_in 'accountid', with: 'hogehoge'
        fill_in 'password', with: 'testtest'
        click_button 'ログイン'
      end
      it '画面は変わらない' do
        expect(current_path).to eq login_path
      end
      context '入力を間違えた後、登録されているユーザーのアカウントIDとパスワードを入力した場合' do
        before do
          fill_in 'accountid', with: accountid
          fill_in 'password', with: password
          click_button 'ログイン'
          expect(page).to have_content 'タスク一覧'
        end
        it 'タスク一覧画面に遷移する'
        context 'ログインした後' do
          before { visit tasks_path }
          it 'ログインのリンクが表示されなくなり、ログアウトのリンクが表示される' do
            expect(page).not_to have_selector 'a#login_link', text: 'ログイン'
            expect(page).to have_selector 'a#logout_link', text: 'ログアウト'
          end
        end
      end
    end
  end
  describe 'ログアウト' do
    let!(:user) { create(:user, accountid: 'Iamtest', password: 'testPassword') }
    before  do
      visit login_path
      fill_in 'accountid', with: 'Iamtest'
      fill_in 'password', with: 'testPassword'
      click_button 'ログイン'
      expect(page).to have_content 'タスク一覧'
      visit tasks_path
      click_link 'ログアウト'
    end
    context '確認ダイアログでYesを押した場合' do
      before { page.driver.browser.switch_to.alert.accept }
      it 'ログイン画面に遷移する'
      context 'ログアウトした後' do
        before { visit tasks_path }
        it 'ログアウトのリンクが表示されなくなり、ログインのリンクが表示される'
      end
    end
    context '確認ダイアログでNoを押した場合' do
      before { page.driver.browser.switch_to.alert.dismiss }
      it '画面は変わらない'
      it 'ログアウトのリンクが表示され、ログインのリンクは表示されない' do
        expect(page).not_to have_selector 'a#login_link', text: 'ログイン'
        expect(page).to have_selector 'a#logout_link', text: 'ログアウト'
      end
    end
  end
end
