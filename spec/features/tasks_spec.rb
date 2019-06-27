# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature, js: true do
  context 'ログインしている場合'
    describe 'タスクの一覧表示'
      describe '最初の並び順'
        it 'indexページに投稿されたタスクの一覧が表示される'
        it 'ページ遷移後、投稿日が新しい順に並んでいる'

      describe '並び替え'
        context '投稿日が新しい順'
          it '投稿日が新しい順に並び替える'
        context '投稿日が古い順'
          it '投稿日が古い順に並び替える'
        context '期限日が近い順'
          it '期限が近い順に並び替える'
        context '期限日が遠いの順'
          it '期限が遠い順に並び替える'
        context '優先度が高い順'
          it '優先度が高い順に並び替える'
        context '優先度が低い順'
          it '優先度が低い順に並び替える'

    describe 'タスクを表示しているページの切り替え'
      context '10個以下の場合'
        it '10個まで表示される'
        it 'ページネーションできない'
      context 'タスクが11個以上から20個の場合'
        it '2ページ目に11個目から20個目までが表示される'

  context 'ログインしていない場合'
    context 'ログインせず、別の画面に遷移しようとした場合'
      it 'ログイン画面に遷移する'
    context 'ログイン画面から別の画面に遷移しようとした場合'
      context 'タスク一覧画面に遷移しようとした場合'
        it 'ログイン画面に遷移する'
      context 'タスク投稿画面に遷移しようとした場合'
        it 'タスク投稿画面に遷移しようとしても、ログイン画面に遷移する'
end
