# frozen_string_literal: true

class Api::TasksController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @tasks = Task.order(created_at: 'DESC').page(params[:page]).per(10)
  end
end
