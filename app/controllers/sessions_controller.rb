# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def create
    user = User.find_by(accountid: params[:session][:accountid])
    if user.present? && user.authenticated?(params[:session][:password])
      log_in(user)
      make_long_duration_cookie(user)
      render json: 'ログインに成功しました', status: 200
    else
      render json: 'ログインに失敗しました', status: 401
    end
  end
end

# 飛んでくるparams
# params[:session][:accountid]
# params[:session][:password]
