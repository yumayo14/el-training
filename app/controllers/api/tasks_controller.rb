class Api::TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: 'DESC')
  end
end
