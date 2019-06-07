# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session', type: :request do
  describe 'POST#create' do
    let!(:user) { create(:user, name: 'Json', accountid: 'Iamtest', password: 'thisisTest') }
    let!(:log_in) do
      post login_path, params: {
        accountid: input_accountid,
        password: input_password
      }
    end
    context '登録されたユーザーアカウントと同じアカウントIDとパスワードのアカウントがあった場合' do
      let(:input_accountid) { 'Iamtest' }
      let(:input_password) { 'thisisTest' }
      let(:response_for_authenticated_user) { JSON.parse(response.body) }
      it 'sessionが発行される' do
        expect(session[:session_id]).to be_present
        expect(session[:user_id]).to eq user.id
      end
      it 'レスポンスヘッダーにSet-Cookieが含まれる' do
        expect(response.headers['Set-Cookie']).to be_present
      end
      it 'レスポンスに暗号化されたユーザーIDの情報が含まれる' do
        expect(response.cookies['user_id']).to eq cookies['user_id']
      end
      it 'レスポンスに記憶トークンが含まれている' do
        expect(response.cookies['user_token']).to eq cookies['user_token']
      end
      it 'レスポンスで認証されたユーザーのインスタンスが返る' do
        expect(response_for_authenticated_user['user']['name']).to eq 'Json'
        expect(response_for_authenticated_user['user']['accountid']).to eq 'Iamtest'
      end
      it 'レスポンスのステータスが200' do
        expect(response.status).to eq 200
      end
      context '成功後、別のリクエストを投げる場合' do
        it 'レスポンスヘッダーにSet-Cookieが含まれる' do
          get tasks_path
          expect(response.headers['Set-Cookie']).to be_present
        end
        it 'レスポンスに暗号化されたユーザーIDの情報が含まれる' do
          expect(response.cookies['user_id']).to eq cookies['user_id']
        end
        it 'レスポンスに記憶トークンが含まれている' do
          expect(response.cookies['user_token']).to eq cookies['user_token']
        end
      end
    end
    context '登録されたユーザーアカウントと同じアカウントIDとパスワードのアカウントがなかった場合' do
      let(:input_accountid) { 'Iamwrong' }
      let(:input_password) { 'thisisBadTest' }
      it 'sessionが発行されない' do
        expect(session[:session_id]).to be_nil
      end
      it 'レスポンスヘッダーにSet-Cookieが含まれない' do
        expect(response.header['Set-Cookie']).to be_nil
      end
      it 'レスポンスでアラートメッセージが返ってくる' do
        expect(response.body).to eq 'ログインに失敗しました。IDとパスワードを確認してください。'
      end
      it 'レスポンスのステータスが401' do
        expect(response.status).to eq 401
      end
    end
  end
  describe 'DELETE#destroy' do
    let!(:user) { create(:user, name: 'Json', accountid: 'Iamtest', password: 'thisisTest') }
    let!(:log_in) do
      post login_path, params: {
          accountid: 'Iamtest',
          password: 'thisisTest'
      }
    end
    before do
      delete logout_path
    end
    context 'ログイン済みのユーザーの場合' do
      it 'sessionからユーザーIDの値が削除される' do
        expect(session[:user_id]).to eq nil
      end
      it 'レスポンスのステータスが200' do
        expect(response.status).to eq 200
      end
      it 'レスポンスから暗号化されたユーザーIDの情報が取り除かれる' do
        expect(response.cookies['user_id']).to eq nil
      end
      it 'レスポンスからユーザーの記憶トークンが取り除かれる' do
        expect(response.cookies['user_token']).to eq nil
      end
    end
  end
end
