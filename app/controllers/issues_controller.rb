# frozen_string_literal: true

class IssuesController < ApplicationController
  include SessionsHelper
  before_action :require_login

  def index; end

  def show; end
end
