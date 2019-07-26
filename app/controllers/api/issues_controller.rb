# frozen_string_literal: true

class Api::IssuesController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  include SessionsHelper

  def index
    @issues = current_user.issues
    render json: @issues, status: 200
  end
end
