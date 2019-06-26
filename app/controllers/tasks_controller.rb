# frozen_string_literal: true

class TasksController < ApplicationController
  include SessionsHelper
  before_action :require_login

  def index; end

  def new; end
end
