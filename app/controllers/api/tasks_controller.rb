# frozen_string_literal: true

class Api::TasksController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @tasks = if params[:title] || params[:status]
               login_user.tasks.search(params[:title], params[:status]).orderd_by(:desc).page(params[:page]).per(10)
             else
               login_user.tasks.orderd_by(:desc).page(params[:page]).per(10)
             end
  end

  private

  def login_user
    User.find(cookies.signed[:user_id])
  end
end
