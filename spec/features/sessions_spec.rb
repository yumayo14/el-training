# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sessions', type: :feature, js: true do
  describe 'ログイン'
  context '登録されているユーザーと同じアカウントIDとパスワードが入力されている場合'
  it 'タスク一覧画面に遷移する'
  context 'ログインした後'
  it 'ログインのリンクが表示されなくなり、ログアウトのリンクが表示される'
  context '登録されているユーザーとアカウントIDとパスワードが異なる場合'
  it '画面は変わらない'
  context '入力を間違えた後、登録されているユーザーのアカウントIDとパスワードを入力した場合'
  it 'タスク一覧画面に遷移する'
  context 'ログインした後'
  it 'ログインのリンクが表示されなくなり、ログアウトのリンクが表示される'

  describe 'ログアウト'
  context '確認ダイアログでYesを押した場合'
  it 'ログイン画面に遷移する'
  context 'ログアウトした後'
  it 'ログアウトのリンクが表示されなくなり、ログインのリンクが表示される'
  context '確認ダイアログでNoを押した場合'
  it '画面は変わらない'
  it 'ログアウトのリンクが表示され、ログインのリンクは表示されない'
end
