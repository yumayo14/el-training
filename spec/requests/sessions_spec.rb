# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session', type: :request do
  describe 'POST#create' do
    let!(:user) { create(:user, name: 'Json', accountid: 'Iamtest', hashed_password: 'thisisTest') }
    let!(:log_in) do
      post sessions_path, params: {
        session: {
          accountid: input_accountid,
          password: input_password
        }
      }
    end
    context '登録されたユーザーアカウントと同じアカウントIDとパスワードのアカウントがあった場合' do
      let(:input_accountid) { 'Iamtest' }
      let(:input_password) { 'thisisTest' }
      let(:responsed_user) { JSON.parse(response.body) }
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
        expect(responsed_user['name']).to eq 'Json'
        expect(responsed_user['accountid']).to eq 'Iamtest'
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
        expect(response.body).to eq 'ログインに失敗しました'
      end
      it 'レスポンスのステータスが401' do
        expect(response.status).to eq 401
      end
    end
  end
end
