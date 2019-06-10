# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper
  LOGIN_SUCCESS_URL = '/tasks'
  def new; end

  def create
    @user = User.find_by(accountid: params[:accountid])
    if @user.present? && @user.authenticated?(params[:password])
      log_in @user
      make_long_duration_cookie_for @user
      render json: { user: @user, redirect_url: LOGIN_SUCCESS_URL }, status: 200
    else
      render json: 'ログインに失敗しました。IDとパスワードを確認してください。', status: 401
    end
  end
end
