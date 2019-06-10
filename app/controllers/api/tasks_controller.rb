# frozen_string_literal: true

class Api::TasksController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  include SessionsHelper
  def index
    @tasks = if params[:title] || params[:status]
               current_user.tasks.search(params[:title], params[:status]).orderd_by(:desc).page(params[:page]).per(10)
             else
               current_user.tasks.orderd_by(:desc).page(params[:page]).per(10)
             end
  end
end
