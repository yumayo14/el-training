# frozen_string_literal: true

class TasksController < ApplicationController
  include SessionsHelper
  before_action :set_task, only: %i(show edit update destroy)
  before_action :require_login

  def index; end

  def new; end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクの内容が更新されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :importance, :dead_line_on, :status, :detail, :user_id)
  end
end
