# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session', type: :request do
  describe 'ログイン  ' do
    let!(:user) { create(:user, accountid: 'Iamtest', hashed_password: 'thisisTest') }
    let!(:log_in) do
      post sessions_path, params: {
        session: {
          accountid: input_accountid,
          password: input_hashed_password
        }
      }
    end
    context '登録されたユーザーアカウントと同じアカウントIDとパスワードのアカウントがあった場合' do
      let(:input_accountid) { 'Iamtest' }
      let(:input_hashed_password) { 'thisisTest' }
      it 'sessionが発行される' do
        expect(session[:session_id]).to be_present
        expect(session[:user_id]).to eq user.id
      end
      it 'レスポンスヘッダーにSet-Cookieが含まれる' do
        expect(response.headers['Set-Cookie']).to be_present
      end
    end
    context '登録されたユーザーアカウントと同じアカウントIDとパスワードのアカウントがなかった場合' do
      let(:input_accountid) { 'Iamwrong' }
      let(:input_hashed_password) { 'thisisBadTest' }
      it 'sessionが発行されない' do
        expect(session[:session_id]).to be_nil
      end
      it 'レスポンスヘッダーにSet-Cookieが含まれない' do
        expect(response.header['Set-Cookie']).to be_nil
      end
    end
  end
end
