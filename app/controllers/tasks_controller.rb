class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order(created_at: 'DESC')
  end

  def new
    @task = Task.new
  end

  def create
    if Task.create(task_params)
      redirect_to tasks_path, notice: "新しいタスクが作成されました"
    else
      render :new, alert: "タスクの作成に失敗しました"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクの内容が変更されました"
    else
      render :edit, alert: "タスクの内容の変更に失敗しました"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

 private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :importance, :dead_line_on, :status, :detail)
  end
end
