# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def create
    user = User.find_by(accountid: params[:session][:accountid])
    if user.present? && user.authenticate?(params[:session][:password])
      log_in(user)
      render json: 'ログインに成功しました', status: 200
    else
      render json: 'ログインに失敗しました', status: 401
    end
  end
end

# 飛んでくるparams
# params[:session][:accountid]
# params[:session][:password]
