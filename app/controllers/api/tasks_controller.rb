# frozen_string_literal: true

class Api::TasksController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  CREATE_SUCCESS_URL = '/tasks'
  include SessionsHelper
  def index
    @tasks = if params[:title] || params[:status]
               current_user.tasks.search(params[:title], params[:status]).orderd_by(:desc).page(params[:page]).per(10)
             else
               current_user.tasks.orderd_by(:desc).page(params[:page]).per(10)
             end
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: { task: @task, redirect_url: CREATE_SUCCESS_URL }, status: 200
    else
      render json: @task.errors.full_messages, status: 400
    end
  end

  private

  def task_params
    params.permit(:title, :importance, :dead_line_on, :status, :detail, :user_id)
  end
end
