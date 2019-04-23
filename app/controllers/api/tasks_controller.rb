class Api::TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: 'DESC').page(params[:page]).per(10)
  end
end
