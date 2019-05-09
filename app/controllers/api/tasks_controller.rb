# frozen_string_literal: true

class Api::TasksController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def index
    @tasks = if params[:title] || params[:status]
               Task.search(params[:title], params[:status]).orderd_by(:desc).page(params[:page]).per(10)
             else
               Task.all.orderd_by(:desc).page(params[:page]).per(10)
             end
  end
end
