# frozen_string_literal: true

class Api::TasksController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  SUCCESS_URL_AFTER_ALL_ACTION = '/tasks'
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error_message_and_status
  before_action :set_task, only: %i(destroy)
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
      render json: { task: @task, redirect_url: SUCCESS_URL_AFTER_ALL_ACTION }, status: 200
    else
      render json: @task.errors.full_messages, status: 400
    end
  end

  def destroy
    @task.destroy
    render json: SUCCESS_URL_AFTER_ALL_ACTION, status: 200
  end

  private

  def task_params
    params.permit(:title, :importance, :dead_line_on, :status, :detail, :user_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def render_not_found_error_message_and_status
    render json: '選択したタスクが見つかりませんでした', status: 404
  end
end
