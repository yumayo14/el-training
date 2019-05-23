# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def create
    user = User.find_by(accountid: params[:session][:accountid])

    log_in(user) if user.present? && user.authenticate?(params[:session][:password])
  end
end

# 飛んでくるparams
# params[:session][:accountid]
# params[:session][:password]
